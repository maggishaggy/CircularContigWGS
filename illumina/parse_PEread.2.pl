#!/usr/bin/perl
use strict;
#Zhuofei Xu, Sep 11, 2012
die "Usage: perl $0 hitread2left.tab > hitread2left.reverse.tab \n" if (@ARGV != 1);

open(LIST,$ARGV[0]) or die "cannot open $ARGV[0]\n";

my $count = 0;

while(<LIST>){
	chomp;
	if(/^(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/){
		my $sstart = $9;
		my $sends = $10;
		my $hitlen = ($sends - $sstart);
		if ($hitlen < 0){
			print "$_\n";
		}
	}
}
close LIST;
