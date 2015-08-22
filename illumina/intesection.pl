#! /usr/bin/perl -w
use strict;

open (DATA, $ARGV[0])||die "Can't open file $ARGV[0]:$!\n";
open (FILE, $ARGV[1])||die "Can't open file $ARGV[1]:$!\n";

my %hash = ();

while (<DATA>){
	chomp;
	if (/^>(\S+)$/){
		$hash{$1} = $1;
	}
}
close (DATA);

while (<FILE>){
	chomp;
	if (/^(\S+)/){
		my $name = $1;
		if (exists $hash{$name}){
		print "$_\n";
	}
}
}
close (FILE);