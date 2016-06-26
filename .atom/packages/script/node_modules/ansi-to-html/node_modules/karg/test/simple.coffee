
args = require('../') """

simple
    additional  . ? unnamed argument  . * . = no name
    anOption    . ? some description  . = default
    boolean     . ? -b to turn it on  . = false
    switch      . ? -s to turn it off . = true
    invisible                 . = hidden
    
additional help topic
    some help
    
version       1.0.0

"""

console.log require('noon').stringify args, colors:true
