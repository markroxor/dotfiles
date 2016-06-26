
/*
000   000   0000000   00000000    0000000 
000  000   000   000  000   000  000      
0000000    000000000  0000000    000  0000
000  000   000   000  000   000  000   000
000   000  000   000  000   000   0000000
 */

(function() {
  var _, colors, error, expand, log, noon, parse,
    indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  noon = require('noon');

  colors = require('colors');

  _ = require('lodash');

  log = console.log;


  /*
  00000000  000   000  00000000    0000000   000   000  0000000  
  000        000 000   000   000  000   000  0000  000  000   000
  0000000     00000    00000000   000000000  000 0 000  000   000
  000        000 000   000        000   000  000  0000  000   000
  00000000  000   000  000        000   000  000   000  0000000
   */

  expand = function(l) {
    var a, j, len, match;
    for (j = 0, len = l.length; j < len; j++) {
      a = l[j];
      if (match = /^\-(\w\w+)$/.exec(a)) {
        a = match[1].split('').map(function(i) {
          return '-' + i;
        });
        a.unshift(l.indexOf(match.input), 1);
        l.splice.apply(l, a);
        return expand(l);
      }
    }
    return l;
  };


  /*
  00000000  00000000   00000000    0000000   00000000 
  000       000   000  000   000  000   000  000   000
  0000000   0000000    0000000    000   000  0000000  
  000       000   000  000   000  000   000  000   000
  00000000  000   000  000   000   0000000   000   000
   */

  error = function(msg) {
    var s;
    s = "[".dim.red + "ERROR".bold.dim.red + "] ".dim.red;
    s += msg.trim().split('\n').join("\n        ").red;
    return log(s);
  };


  /*
  00000000    0000000   00000000    0000000  00000000
  000   000  000   000  000   000  000       000     
  00000000   000000000  0000000    0000000   0000000 
  000        000   000  000   000       000  000     
  000        000   000  000   000  0000000   00000000
   */

  parse = function(config, options) {
    var a, c, df, h, help, k, l, maxHelpLength, maxKeyLength, n, oh, p, r, ref, ref1, s, short, v, version;
    if (options == null) {
      options = {};
    }
    a = expand(process.argv.slice(2));
    c = noon.parse(config);
    n = Object.keys(c)[0];
    r = {};
    p = '';
    l = false;
    help = {};
    short = {};
    ref = c[n];
    for (k in ref) {
      v = ref[k];
      if (0 <= k.indexOf(' ')) {
        error("wrong karg setup: " + "keys can't contain spaces!".bold + "\nbroken key: " + k.bold.yellow);
        process.exit(1);
      }
      if (v['='] != null) {
        r[k] = v['='];
      }
      s = (v['-'] != null) && v['-'] || k[0];
      if (indexOf.call(Object.keys(v), '*') >= 0) {
        p = k;
      } else if (indexOf.call(Object.keys(v), '**') >= 0) {
        p = k;
        l = true;
        r[p] = [];
      } else {
        short[s] = k;
        help[s] = v['?'];
      }
    }

    /*
     0000000   00000000   000000000  000   0000000   000   000   0000000
    000   000  000   000     000     000  000   000  0000  000  000     
    000   000  00000000      000     000  000   000  000 0 000  0000000 
    000   000  000           000     000  000   000  000  0000       000
     0000000   000           000     000   0000000   000   000  0000000
     */
    oh = "";
    maxKeyLength = 0;
    maxHelpLength = 0;
    for (s in short) {
      k = short[s];
      if (help[s] != null) {
        maxKeyLength = Math.max(maxKeyLength, s.length + k.length);
        maxHelpLength = Math.max(maxHelpLength, help[s].strip.length);
      }
    }
    for (s in short) {
      k = short[s];
      if (help[s] != null) {
        df = (function() {
          switch (r[k]) {
            case false:
              return '✘'.red.dim;
            case true:
              return '✔'.green.bold;
            default:
              return r[k];
          }
        })();
        oh += '\n';
        oh += "    " + '-'.gray + s + ', --'.gray + k;
        oh += ("    " + (_.padEnd('', Math.max(0, maxKeyLength - s.length - k.length))) + " " + help[s]).gray.bold;
        if (df != null) {
          oh += ("    " + (_.padEnd('', Math.max(0, maxHelpLength - help[s].strip.length))) + " " + df).magenta;
        }
      }
    }

    /*
    000   000  00000000  000      00000000 
    000   000  000       000      000   000
    000000000  0000000   000      00000000 
    000   000  000       000      000      
    000   000  00000000  0000000  000
     */
    h = "\n" + 'usage:'.gray + "  " + n.bold + " ";
    if (1 < _.size(short)) {
      h += "" + '['.gray + 'options'.bold.gray + ']'.gray + " ";
    }
    h += "" + '['.gray + p.bold.yellow + (l && ' ... ]'.gray || ']'.gray);
    h += '\n';
    if ((ref1 = c[n][p]) != null ? ref1['?'] : void 0) {
      h += ("\n" + (_.padEnd('        ' + p, maxKeyLength + 9)) + " " + c[n][p]['?'].gray).yellow.bold;
      if ((c[n][p]['='] != null) && !l) {
        h += ("  " + (_.padEnd('', Math.max(0, maxHelpLength - c[n][p]['?'].strip.length))) + " " + c[n][p]['=']).magenta;
      }
      h += '\n';
    }
    if (oh.length) {
      h += "\noptions:\n".gray;
      h += oh;
      h += '\n\n';
    }
    short['h'] = 'help';
    if (c['version'] != null) {
      version = c['version'];
      delete c['version'];
      short['V'] = 'version';
    }
    delete c[n];
    if (!_.isEmpty(c)) {
      h += noon.stringify(c, {
        maxalign: 16,
        colors: {
          key: colors.gray,
          string: colors.white
        }
      });
      h += '\n';
    }

    /*
    00000000   00000000   0000000  000   000  000      000000000
    000   000  000       000       000   000  000         000   
    0000000    0000000   0000000   000   000  000         000   
    000   000  000            000  000   000  000         000   
    000   000  00000000  0000000    0000000   0000000     000
     */
    while (a.length) {
      k = a.shift();
      if (k.substr(0, 2) === '--') {
        k = k.substr(2);
      } else if (k[0] === '-') {
        k = short[k.substr(1)];
      } else {
        if (l) {
          r[p].push(k);
        } else {
          r[p] = k;
        }
        continue;
      }
      if (k === 'help') {
        log(h);
        if (options.dontExit) {
          return;
        }
        process.exit();
      } else if (k === 'version' && (version != null)) {
        log(version);
        if (options.dontExit) {
          return;
        }
        process.exit();
      }
      if (r[k] === false || r[k] === true) {
        r[k] = !r[k];
      } else if (!isNaN(parseInt(r[k]))) {
        r[k] = parseInt(a.shift());
      } else if (indexOf.call(_.values(short), k) >= 0) {
        r[k] = a.shift();
      } else {
        if (l) {
          r[p].push(k);
        } else {
          r[p] = k;
        }
      }
    }
    return r;
  };

  module.exports = parse;

}).call(this);
