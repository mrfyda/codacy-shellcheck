##Patterns: SC2015

##Info: SC2015
[[ $dryrun ]] && echo "Would delete file" || rm file

if [[ $dryrun ]]
then
  echo "Would delete file"
else
  rm file
fi
