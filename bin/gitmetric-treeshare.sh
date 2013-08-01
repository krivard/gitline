#!/bin/bash

H=""
A=""
D=""
S=""
OIFS=$IFS
IFS='%'
git log --numstat --format="%% %h%%%aN%%%ad%%%s" --date=short --reverse|
while read rev;
do
    if [ -z "$rev" ] ; then continue; fi
    if [[ $rev == %* ]]
    then
	infarr=(${rev:2})
	H=${infarr[0]}
	A=${infarr[1]}
	D=${infarr[2]}
	S=${infarr[3]}
	continue
    else
	echo -e "$H\t$A\t$D\t$S\t$rev"
    fi
done
IFS=$OIFS