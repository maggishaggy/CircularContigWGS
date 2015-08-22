#!/usr/bin/perl
use strict;
#Zhuofei Xu, April 03, 2013
die "Usage: perl $0 xaa2contigleft.blastn > matched.read.list \n" if (@ARGV != 1);

open(LIST,$ARGV[0]) or die "cannot open $ARGV[0]\n";

my $count = 0;
my $len = 0;

while(<LIST>){
	chomp;
	$len = 0;
	if(/^(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/){
		my $name = $1;
		my $identity = $3;
		my $qstart = $7;
		my $qends = $8;
		if($name =~ /:(\d+)$/){
			$len = $1;
		}
		my $hitlen = ($qends - $qstart + 1);
		my $cover = $hitlen/$len;
		if (($identity == 100) && ($hitlen >= 90) && ($cover >= 0.99)){
			print "$_\n";
		}
	}
}
close LIST;
