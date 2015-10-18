#!/bin/bash

for i in {0..99}
do
   curl -s -o SC1`printf %03d $i`.md https://raw.githubusercontent.com/wiki/koalaman/shellcheck/SC1`printf %03d $i`.md
done

for i in {0..199}
do
   curl -s -o SC2`printf %03d $i`.md https://raw.githubusercontent.com/wiki/koalaman/shellcheck/SC2`printf %03d $i`.md
done

rm -f `fgrep -lir 'Not Found' *.md`
