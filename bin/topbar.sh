#!/bin/bash
{
cat<<EOF 
<div id="topbar">
<table>
<tr>
EOF

for a in `grep "^author" gitline.conf | sed 's/author //;s/=.*//'`
do
    echo "<td class=\"$a contrib ex\">&nbsp;</td>"
    echo "<td class=\"name\">${a//_/ }</td>"
done
cat <<EOF
</tr>
</table>
</div>


EOF
} > www/topbar.html
