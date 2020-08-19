##Patterns: SC2033

foo() { bar --baz "$@"; frob --baz "$@"; };
##Warning: SC2033
find . -exec foo {} +

find . -exec sh -c 'bar --baz "$@"; frob --baz "$@";' -- {} +
