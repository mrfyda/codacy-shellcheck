#!/bin/bash

SCRIPT_HOME="$( cd "$( dirname "$0" )" && pwd )"
DOCS_HOME="${SCRIPT_HOME}/../src/main/resources/docs"
DESCRIPTION_HOME="${DOCS_HOME}/description"
VERSION="v0.5.0"

rm -rf shellcheck shellcheck.wiki
git clone -b $VERSION --single-branch --depth 1 https://github.com/koalaman/shellcheck.git
git clone https://github.com/koalaman/shellcheck.wiki.git

cd shellcheck.wiki

# delete removed patterns
for f in SC*; do
  pattern_id=`echo $f | awk '{print substr($0,3,4)}'`
  grep -r $pattern_id ../shellcheck/src/ShellCheck &>/dev/null
  if [ $? -eq 0 ] ; then
    echo "Generating docs for $pattern_id"
  else
    rm $f
  fi
done

# patterns.json
for f in SC*; do
  pattern_id=`echo $f | awk '{print substr($0,0,6)}'`
  [ -n "$patterns" ] && patterns+=","
  internal_id=`echo $pattern_id | grep -o '[0-9]\+'`
  category=`cat $SCRIPT_HOME/categories.json | jq -SM ".[] | select(.patternId==\"$pattern_id\") | .category" | tr -d '"'`
  category=${category:=CodeStyle}
  severity=`grep -hR $internal_id ../shellcheck`
  case $severity in
    *"err"*) level="Error" ;;
    *"ErrorC"*) level="Error" ;;
    *"warn"*) level="Warning" ;;
    *"WarningC"*) level="Warning" ;;
    *"info"*) level="Info" ;;
    *"InfoC"*) level="Info" ;;
    *) level="Info" ;;
  esac
  patterns+=$(jq -cMn --arg patternId "$pattern_id" --arg level "$level" --arg category "$category" '{"patternId": $patternId, "level": $level, "category": $category}')
done

jq -Mn --arg version "$VERSION" --argjson patterns "[$patterns]" '{"name": "shellcheck", "version": $version, "patterns": $patterns}' > "${DOCS_HOME}/patterns.json"

# description.json
for f in SC*; do
  pattern_id=`echo $f | awk '{print substr($0,0,6)}'`
  title=$(head -n 1 $f | sed 's/^#* *//')
  [ -n "$descriptions" ] && descriptions+=","
  descriptions+=$(jq -cMn --arg patternId "$pattern_id" --arg title "$title" '{"patternId": $patternId, "title": $title, "description": $title, "timeToFix": 5}')
done

jq -Mn --argjson descriptions "[$descriptions]" '$descriptions' > "${DESCRIPTION_HOME}/description.json"

# Documentation
for f in SC*; do
   name=`echo $f | awk '{print substr($0,0,6)}'`
   file="${DESCRIPTION_HOME}/${name}.md"
   cp $f $file
   pattern_id=${f%.*}
   echo "" >> $file
   echo "[Source](https://github.com/koalaman/shellcheck/wiki/${pattern_id})" >> $file
   echo "" >> $file
done
