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
    $users{$author}=0;
}

my @colors=("dd9966","66cc66","cccc66","8888dd",
    "dd6699","99dd66","66dd99","cc6666","66dd66","6666dd","66cccc","cc66cc","dd8888","88dd88");

open (my $conf,">>gitline.conf") or die "Couldn't open file gitline.conf for writing:\n$!\n";
my $i=0;
foreach my $author (keys %users) {
    my $authkey=$author;
    $authkey =~ s/ /_/g;
    print $conf "author $authkey=#$colors[$i]\n";
    $i++;
    if ($i > $#colors) { $i=0; }
}
close($conf) or die "Couldn't close file gitline.conf:\n$!\n";
