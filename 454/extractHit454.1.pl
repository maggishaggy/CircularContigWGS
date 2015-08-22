#! user/bin/perl -w
use strict;
#Zhuofei Xu, 2012-06-20
die "Usage: perl $0 blastn.out > out\n" unless (@ARGV == 1);

open (FILE, "$ARGV[0]")||die "cannot open $ARGV[0]\n";
my $identity = 0;
my $alnlen = 0;
my $gap = 0;

while (<FILE>){
	chomp;
	  if (/^(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+/){
	  	$identity = $3;
	  	$alnlen = $4;
	  	$gap = $6;
	  	if(($identity >= 99) && ($alnlen == 200) && ($gap == 0)){
	  		print "$_\n";
	  	}
	}
}
close (FILE);