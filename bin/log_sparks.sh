#!/bin/bash


mkdir -p $1
for f in $2/*.dat
do
    b=$(basename "$f")
    echo $f
    bin/spark.sh $f $1/${b%.*}.png
done