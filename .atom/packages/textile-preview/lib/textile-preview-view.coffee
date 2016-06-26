path = require 'path'
fs = require 'fs-plus'

{Emitter, Disposable, CompositeDisposable, File} = require 'atom'
{$, $$$, ScrollView} = require 'atom-space-pen-views'
_ = require 'underscore-plus'

renderer = require './renderer'

module.exports =
class TextilePreviewView extends ScrollView
  @content: ->
    @div class: 'textile-preview native-key-bindings', tabindex: -1

  constructor: ({@editorId, @filePath}) ->
    super
    @emitter = new Emitter
    @disposables = new CompositeDisposable
    @loaded = false

  attached: ->
    return if @isAttached
    @isAttached = true

    if @editorId?
      @resolveEditor(@editorId)
    else
      if atom.workspace?
        @subscribeToFilePath(@filePath)
      else
        @disposable.add atom.packages.onDidActivateInitialPackages =>
          @subscribeToFilePath(@filePath)

  serialize: ->
    deserializer: 'TextilePreviewView'
    filePath: @getPath() ? @filePath
    editorId: @editorId

  destroy: ->
    @disposables.dispose()

  onDidChangeTitle: (callback) ->
    @emitter.on 'did-change-title', callback

  onDidChangeModified: (callback) ->
    new Disposable

  onDidChangeTextile: (callback) ->
    @emitter.on 'did-change-textile', callback

  subscribeToFilePath: (filePath) ->
    @file = new File(filePath)
    @emitter.emit 'did-change-title'
    @handleEvents()
    @renderTextile()

  resolveEditor: (editorId) ->
    resolve = =>
      @editor = @editorForId(editorId)

      if @editor?
        @emitter.emit 'did-change-title' if @editor?
        @handleEvents()
        @renderTextile()
      else
        atom.workspace?.paneForItem(this)?.destroyItem(this)

    if atom.workspace?
      resolve()
    else
      @disposables.add atom.packages.onDidActivateInitialPackages(resolve)

  editorForId: (editorId) ->
    for editor in atom.workspace.getTextEditors()
      return editor if editor.id?.toString() is editorId.toString()
    null

  handleEvents: ->
    @disposables.add atom.grammars.onDidAddGrammar => _.debounce((=> @renderTextile()), 250)
    @disposables.add atom.grammars.onDidUpdateGrammar _.debounce((=> @renderTextile()), 250)

    atom.commands.add @element,
      'textile-preview:zoom-in': =>
        z = parseFloat(@css('zoom')) or 1
        @css('zoom', z + .1)
      'textile-preview:zoom-in': =>
        z = parseFloat(@css('zoom')) or 1
        @css('zoom', z + .1)
      'textile-preview:zoom-out': =>
        z = parseFloat(@css('zoom')) or 1
        @css('zoom', z - .1)
      'textile-preview:zoom-reset': =>
        @css('zoom', 1)

    changeHandler = =>
      @renderTextile()
      # TODO: remove paneForURI
      pane = atom.workspace.paneForItem?(this) ? atom.workspace.paneForURI(@getURI())
      if pane? and pane isnt atom.workspace.getActivePane()
        pane.activateItem(this)

    if @file?
      @disposables.add @file.onDidChange(changeHandler)
    else if @editor?
      @disposables.add @editor.getBuffer().onDidStopChanging ->
        changeHandler()
      @disposables.add @editor.onDidChangePath => @emitter.emit 'did-change-title'

  renderTextile: ->
    @showLoading() unless @loaded
    @getTextileSource().then (source) => @renderTextileText(source) if source?

  getTextileSource: ->
    if @file?.getPath()
      @file.read()
    else if @editor?
      Promise.resolve(@editor.getText())
    else
      Promise.resolve(null)

  renderTextileText: (text) ->
    renderer.toDOMFragment text, @getPath(), (error, domFragment) =>
      if error
        @showError(error)
      else
        @loading = false
        @loaded = true
        @html(domFragment)
        @emitter.emit 'did-change-textile'

  getTitle: ->
    if @file?
      "#{path.basename(@getPath())} Preview"
    else if @editor?
      "#{@editor.getTitle()} Preview"
    else
      "Textile Preview"

  getIconName: ->
    "file-text"

  getURI: ->
    if @file?
      "textile-preview://#{@getPath()}"
    else
      "textile-preview://editor/#{@editorId}"

  getPath: ->
    if @file?
      @file.getPath()
    else if @editor?
      @editor.getPath()

  getGrammar: ->
    @editor?.getGrammar()

  getDocumentStyleSheets: ->
    document.styleSheets

  getTextEditorStyles: ->
    textEditorStyles = document.createElement('atom-styles')
    textEditorStyles = initialize(atom.styles)
    textEditorStyles.setAttribute 'context', 'atom-text-editor'
    document.body.appendChild textEditorStyles

    Array.prototype.slice.apply(textEditorStyles.childNodes).map (styleElement) ->
      styleElement.innerText

  getTextilePreviewCSS: ->
    textilePreviewRules = []
    ruleRE = /\.textile-preview/
    cssUrlRE = /url\(atom:\/\/textile-preview\/assets\/(.*)\)/

    for s in @getDocumentStyleSheets()
      if s.rules?
        for r in s.rules
          textilePreviewRules.push(r.cssText) if r.selectorText?.match(ruleRE)?

    textilePreviewRules
      .concat(@getTextEditorStyles())
      .join('\n')
      .replace(/atom-text-editor/g, 'pre.editor-colors')
      .replace(/:host/g, '.host')
      .replace cssUrlRE, (match, assetsName, offset, string) ->
        assetPath = path.join __dirname, '../assets', assetsName
        originalData = fs.readFileSync assetPath, 'binary'
        base64Data = new Buffer(originalData, 'binary').toString('base64')
        "url('data:image/jpeg;base64,#{base64Data}')"

  showError: (result) ->
    failureMessage = result?.message

    @html $$$ ->
      @h2 'Textile preview failed'
      @h3 failureMessage if failureMessage?

  showLoading: ->
    @loading = true
    @html $$$ ->
      @div class: 'textile-spinner', 'Loading Textile\u2026'

  isEqual: (other) ->
    @[0] is other?[0]
