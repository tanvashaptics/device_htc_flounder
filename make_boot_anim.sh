#!/bin/bash  
# the directory of the script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# the temp directory used, within $DIR
WORK_DIR=`mktemp -d -p "$DIR"`

# deletes the temp directory
function cleanup {
  rm -rf "$WORK_DIR"
  echo "Deleted temp working directory $WORK_DIR"
}

# register the cleanup function to be called on the EXIT signal
trap cleanup EXIT
# implementation of script starts here
cd $WORK_DIR
cp $1 $2
unzip $1
convert part0/000.png -background white label:"$3" -gravity Center -append ./000_label.png
cp -f ./000_label.png part0/000.png
rm -f ./000_label.png
zip -0 -u $2 part0/000.png 
