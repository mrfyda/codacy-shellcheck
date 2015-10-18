##Patterns: SC2002

##Info: SC2002
cat file | tr ' ' _ | grep a_
##Info: SC2002
cat file | ( while read i; do echo "${i%?}"; done )

< file tr ' ' _ | grep a_
( while read i; do echo "${i%?}"; done ) < file
