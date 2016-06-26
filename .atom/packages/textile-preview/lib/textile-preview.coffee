url = require 'url'
fs = require 'fs-plus'

TextilePreviewView = null

createTextilePreviewView = (state) ->
  TextilePreviewView ?= require './textile-preview-view'
  new TextilePreviewView(state)

isTextilePreviewView = (object) ->
  TextilePreviewView ?= require './textile-preview-view'
  object instanceof TextilePreviewView

module.exports =
  config:
    openPreviewInSplitPane:
      type: 'boolean'
      default: true
      description: 'Open the preview in a split pane. If disabled, the preview is opened in a new tab in the same pane.'
    grammars:
      type: 'array'
      default: [
        'text.html.basic'
        'text.plain'
        'text.plain.null-grammar'
        'text.html.textile'
      ]
      description: 'List of scopes for languages for which previewing is enabled. See [this README](https://github.com/atom/spell-check#spell-check-package-) for more information on finding the correct scope for a specific language.'

  activate: ->
    atom.deserializers.add
      name: 'TextilePreviewView'
      deserialize: (state) ->
        if state.editorId or fs.isFileSync(state.filePath)
          createTextilePreviewView(state)

    atom.commands.add 'atom-workspace',
      'textile-preview:toggle': =>
        @toggle()

    previewFile = @previewFile.bind(this)
    atom.commands.add '.tree-view .file .name[data-name$=\\.txt]', 'textile-preview:preview-file', previewFile

    atom.workspace.addOpener (uriToOpen) ->
      try
        {protocol, host, pathname} = url.parse(uriToOpen)
      catch error
        return

      return unless protocol is 'textile-preview:'

      try
        pathname = decodeURI(pathname) if pathname
      catch error
        return

      if host is 'editor'
        createTextilePreviewView(editorId: pathname.substring(1))
      else
        createTextilePreviewView(filePath: pathname)

  toggle: ->
    if isTextilePreviewView(atom.workspace.getActivePaneItem())
      atom.workspace.destroyActivePaneItem()
      return

    editor = atom.workspace.getActiveTextEditor()
    return unless editor?

    grammars = atom.config.get('textile-preview.grammars') ? []
    return unless editor.getGrammar().scopeName in grammars

    @addPreviewForEditor(editor) unless @removePreviewForEditor(editor)

  uriForEditor: (editor) ->
    "textile-preview://editor/#{editor.id}"

  removePreviewForEditor: (editor) ->
    uri = @uriForEditor(editor)
    previewPane = atom.workspace.paneForURI(uri)
    if previewPane?
      previewPane.destroyItem(previewPane.itemForURI(uri))
      true
    else
      false

  addPreviewForEditor: (editor) ->
    uri = @uriForEditor(editor)
    previousActivePane = atom.workspace.getActivePane()
    options =
      searchAllPanes: true
    if atom.config.get('textile-preview.openPreviewInSplitPane')
      options.split = 'right'
    atom.workspace.open(uri, options).then (textilePreviewView) ->
      if isTextilePreviewView(textilePreviewView)
        previousActivePane.activate()

  previewFile: ({target}) ->
    filePath = target.dataset.path
    return unless filePath

    for editor in atom.workspace.getTextEditors() when editor.getPath() is filePath
      @addPreviewForEditor(editor)
      return

    atom.workspace.open "textile-preview://#{encodeURI(filePath)}", searchAllPanes: true
