#!/bin/bash

if [ -z "$2" ]
then
    echo "Usage: ./$0 data.dat output.png [view]"
    exit;
fi

{
cat<<EOF
reset
set terminal png size 200, 30
set output "$2"
set border ""
set lmargin 0
set rmargin 0
set tmargin 0
set bmargin 0
unset xtics
unset ytics
unset key
set xdata time
set timefmt "%Y-%m-%d"

EOF

N=1;
for a in `grep "^author" gitline.conf | sed 's/.*=//'`
do
    echo 'set style line $N lc rgb "$a"'
    N=$(($N+1));
done

cat <<EOF
set style data histograms
set style histogram rowstacked
set style fill solid 

plot \
EOF

for k in 1..$N
do
    echo '"$1" using 1:$((N=1)) with boxes ls $N \'
    if [ $k -lt $N ]; then
	echo ', \'
    fi
done
} | gnuplot

if [ -n "$3" ]
then
    eog $2&
fi