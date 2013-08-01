#!/usr/bin/perl
use constant { true => 1, false => 0 };

my %total, %totaldateuser;
my %ulevel;
my @level;
my %users;
my %datesH;
while(<>) { 
    chomp;
    my ($hash,$author,$date,$desc,$added,$removed,$path) = split '\t';
    my @pp = split('/',$path);
    my $key="";
    my $edits = $added+$removed;
    for (my $i=0; $i<=$#pp; $i++) {
	$key = "$key$pp[$i]";
	if ($i < $#pp) { $key = "$key/"; }
	$total{$key} += $edits;
	$totaldateuser{$key}{$date}{$author} += $edits;
	$level[$i]{$key}=0;
	$ulevel{$key}=$i;
    }
    $datesH{$date}=0;
    $users{$author}=0;
}


my @authors=keys %users;
my @dates=sort keys %datesH;
foreach my $key (keys %total) {
    my $altkey = $key;
    $altkey =~ s/\//__/g;
    my $datfile = "dat/$altkey.dat";
    print "$datfile\n";
    open(my $fh,">$datfile") or die "Couldn't open $datfile for writing:\n$!\n";
    # print header first
    print $fh "#date";
    foreach my $author (@authors) { 
	print $fh "\t$author"; 
	# make sure all plots will be properly timescaled
	$totaldateuser{$key}{$dates[0]}{$author}+=0;
	$totaldateuser{$key}{$dates[$#dates]}{$author}+=0;
    }
    print $fh "\n";
    # then print data
    foreach my $date (sort keys %{ $totaldateuser{$key} } ) {
	print $fh "$date";
	foreach my $author (@authors) {
	    my $var = 0;
	    $var += $totaldateuser{$key}{$date}{$author};
	    print $fh "\t$var";
	}
	print $fh "\n";
    }
    close($fh);
}
