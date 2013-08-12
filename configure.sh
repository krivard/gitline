#!/bin/bash

DIR=$1
if [ -z "$1" ]
then
    echo "Usage: ./configure.sh path/to/.git [http://path/to/display/$filename]"
    exit
fi

if [ -e gitline.conf ]
then
    make cclean
fi

echo "dir=$DIR" > gitline.conf
old=`git config --file $DIR/config mailmap.file`
git config --file $DIR/config mailmap.file $(dirname ${DIR})/.mailmap

URL=$2
echo "url=$URL" >> gitline.conf

make gitline.conf

if [ -n "$old" ]
then
    git config --file $DIR/config mailmap.file $old
fi