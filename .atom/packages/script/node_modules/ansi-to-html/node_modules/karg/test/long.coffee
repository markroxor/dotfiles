
args = require('../') """

long
    veryLongKeyName  . ? some very long description text which doesn't make much sense. . * . = and some default
    anotherLongOne   . ? some modest length description. . = but very long default that doesn't make sense either...
    short   . ? simple . = true
    
some longer help topic header
    some longer help text body content whatever could stand here
"""

console.log require('noon').stringify args, colors:true
