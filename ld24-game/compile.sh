#!/bin/bash

if [ ! -d "$DART_SDK" ]; then
    ${DART_SDK:?"Please set the DART_SDK environment variable to point to your local Dart SDK (get it here: www.dartlang.org)."}
    exit 1
fi

DART="$DART_SDK/bin/dart2js"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
GENERATED="$DIR/generated"

if [ ! -d "$GENERATED" ]; then
    mkdir -p $GENERATED
    [[ ! $? -eq 0 ]] && echo "Could not create output folder $GENERATED. Aborted." && exit 2
fi


for file in `ls $DIR/*.dart`
do
    if [ -f $file ]; then
        filename=$(basename "$file")
        extension="${filename##*.}"
        filename="${filename%.*}"
        output="$filename.js"
        echo "Compilling $filename.dart to $output ..."
        ofile="$GENERATED/$output"
        $DART -o$ofile $file
        rm $ofile.map
    fi
done

echo "Done."


