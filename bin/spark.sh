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

N=0;
for a in `grep "^author" gitline.conf | sed 's/.*=//'`
do
    N=$(($N+1));
    echo -e "set style line $N lc rgb \"$a\""
done

cat <<EOF
set style data histograms
set style histogram rowstacked
set style fill solid 
EOF
echo "plot \\"
for (( k=1; k<=$N; k++ ))
do
    echo -en "\"$1\" using 1:$((k+1)) with boxes ls $k"
    if [ $k -lt $N ]; then
	echo -n ', \'
    fi
    echo
done
} | tee sample.gnuplot | gnuplot

if [ -n "$3" ]
then
    eog $2&
fi