args = require('../') """

minimal
    file  . * . ? arg help
    
"""

console.log require('noon').stringify args, colors:true