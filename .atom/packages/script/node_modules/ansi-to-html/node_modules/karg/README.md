
![icon](./img/icon.png)

### karg

is the german word for **meager**, **barren**, **sparse**

### karg

is also an option parser with **meager features** but **simple setup** and **pretty output**

### meager features

does just the bare minimum:

- short and long option names
- list of unnamed arguments
- boolean toggle
- dictionary output

### simple setup

```coffee
args = require('karg') """

scriptname
    additional  . ? unnamed arguments . **
    anOption    . ? some description  . = default
    boolean     . ? -b to turn it on  . = false
    switch      . ? -s to turn it off . = true
    invisible                         . = hidden
    
additional help topic
    some help
    
version       1.0.0

"""
``` 

### pretty output

![karg](./img/karg.png)
