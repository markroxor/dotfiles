
args = require('../') """

minimal
    file  . * .
    
"""

console.log require('noon').stringify args, colors:true