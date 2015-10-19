##Patterns: SC2013

##Info: SC2013
for line in $(cat file | grep -v '^ *#')
do
  echo "Line: $line"
done

grep -v '^ *#' < file | while IFS= read -r line
do
  echo "Line: $line"
done
