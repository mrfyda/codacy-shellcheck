#!/bin/bash

for i in {0..99}
do
   NAME=SC1`printf %03d $i`
   FILENAME=${NAME}.md

   echo "Downloading ${NAME}..."

   curl -s -o ${FILENAME} https://raw.githubusercontent.com/wiki/koalaman/shellcheck/${FILENAME}
   echo "" >> ${FILENAME}
   echo "[Source](https://github.com/koalaman/shellcheck/wiki/${NAME})" >> ${FILENAME}
   echo "" >> ${FILENAME}
done

for i in {0..199}
do
   NAME=SC2`printf %03d $i`
   FILENAME=${NAME}.md

   echo "Downloading ${NAME}..."

   curl -s -o ${FILENAME} https://raw.githubusercontent.com/wiki/koalaman/shellcheck/${FILENAME}
   echo "" >> ${FILENAME}
   echo "[Source](https://github.com/koalaman/shellcheck/wiki/${NAME})" >> ${FILENAME}
   echo "" >> ${FILENAME}
done

echo "Deleting extra files..."

rm -f `fgrep -lir 'Not Found' *.md`
