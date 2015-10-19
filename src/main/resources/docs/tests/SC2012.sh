##Patterns: SC2012

##Info: SC2012
ls -l | grep " $USER " | grep '\.txt$'

find . -maxdepth 1 -name '*.txt' -user "$USER"
