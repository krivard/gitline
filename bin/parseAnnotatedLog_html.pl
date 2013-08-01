#!/usr/bin/perl
use constant { true => 1, false => 0 };

my %total, %totaluser;
my %ulevel;
my @level;
while(<>) { chomp;
    my ($hash,$author,$date,$desc,$added,$removed,$path) = split '\t';
    my @pp = split('/',$path);
    my $key="";
    my $edits = $added+$removed;
    for (my $i=0; $i<=$#pp; $i++) {
	$key = "$key$pp[$i]";
	if ($i < $#pp) { $key = "$key/"; }
	$total{$key} += $edits;
	$totaluser{$key}{$author} += $edits;
	$level[$i]{$key}=0;
	$ulevel{$key}=$i;
    }
}

my @parent=(-1),$id=0,$lastLevel=0;
foreach my $key (sort(keys(%total))) {
    $id++;
    print "<tr data-tt-id=\"$id\"";

    while ($lastLevel > $ulevel{$key}) {
	$lastLevel--;
	pop @parent;
    }
    if ($#parent>0) {
	print " data-tt-parent-id=\"$parent[$#parent]\"";
    }
    print ">";
    if ($key =~ /\/$/) {
	push @parent, $id;
    }
    
    my $imgkey = $key;
    $imgkey =~ s/\//__/g;
    print "<td class=\"spark\"><img src=\"images/$imgkey.png\"/></td>";
    print "<td class=\"ln\">$total{$key}</td>";
    print "<td><b><a href=\"https://bitbucket.org/malcolmgreaves/kbp_slot_filling_task/src/bc0879277f544f163308e9d408b355eae4523262/$key\">$key</a></b></td>";
    print "</tr>\n";
    $lastLevel=$ulevel{$key};
}
