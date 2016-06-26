
args = require('../') """

complex
    additional    . ? unnamed arguments   . **
    empty         . ? has no default
    string        . ? has string default  . = string
    int           . ? has integer default . = 6
    changedAbbr   . ? has -C as abbr      . - C . = cool
    
help
    some topic  some text  
    another topix  more help
    
version       1.0.0

"""

console.log require('noon').stringify args, colors:true
