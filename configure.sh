#!/bin/bash


make cclean
DIR=$1
if [ -z "$1" ]
then
    DIR=`pwd`/.git
fi
echo "dir=$DIR" > gitline.conf

URL=$2
echo "url=$URL" >> gitline.conf

make gitline.conf