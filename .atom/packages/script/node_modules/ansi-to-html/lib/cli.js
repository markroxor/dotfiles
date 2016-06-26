(function() {
  var args, convert, file, htmlStream, stream;

  args = require('karg')("\nansi-to-html\n    file       . ? the file to display or stdin . *    \n    \n    fg         . ? The background color used for resets . = #000\n    bg         . ? The foreground color used for resets . = #FFF\n    newline    . ? Convert newline characters to <br/>  . = false\n    escapeXML  . ? Generate XML entities                . = false . - x\n    \nversion   " + (require(__dirname + "/../package.json").version));

  file = args.file;

  delete args.file;

  args.stream = true;

  convert = new (require('../'))(args);

  htmlStream = function(stream) {
    return stream.on('data', function(chunk) {
      return process.stdout.write(convert.toHtml(chunk));
    });
  };

  if (file) {
    stream = require('fs').createReadStream(file, {
      encoding: 'utf8'
    });
    htmlStream(stream);
  } else {
    process.stdin.setEncoding('utf8');
    htmlStream(process.stdin);
  }

}).call(this);
