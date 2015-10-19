##Patterns: SC2014

##Info: SC2014
find . -name '*.tar' -exec tar xf {} -C "$(dirname {})" \;

find . -name '*.tar' -exec sh -c 'tar xf "$1" -C "$(dirname "$1")"' _ {} \;
