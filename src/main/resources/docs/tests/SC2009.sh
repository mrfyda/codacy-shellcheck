##Patterns: SC2009

##Info: SC2009
ps ax | grep -v grep | grep "$service" > /dev/null

pgrep -f "$service" > /dev/null
