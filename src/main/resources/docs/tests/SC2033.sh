##Patterns: SC2033

foo() { bar --baz "$@"; frob --baz "$@"; };
##Info: SC2033
find . -exec foo {} +

find . -exec sh -c 'bar --baz "$@"; frob --baz "$@";' -- {} +
