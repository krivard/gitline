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

my @colors=("d96","6c6","cc6","88d",
    "d69","9d6","6d9","c66","6d6","66d","6cc","c6c","d88","8d8");

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
