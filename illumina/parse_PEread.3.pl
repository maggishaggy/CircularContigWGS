#!/usr/bin/perl
use strict;
#Zhuofei Xu, April 04, 2013
die "Usage: perl $0 hitread2left.reverse.tab hitread2right.tab" if (@ARGV != 2);

open(LIST,$ARGV[0]) or die "cannot open $ARGV[0]\n";
open(FILE,$ARGV[1]) or die "can't open $ARGV[1]\n";
open (OUT1, ">circular.PE.list")||die "cannot open $ARGV[0]\n";
open (OUT2, ">circular.PE.read.list")||die "cannot open $ARGV[0]\n";

my $count = 0;
my %hash = ();
my %vash = ();
#HWI-ST897:147:C0MBGACXX:7:1315:8102:91659:2:N:0:CGTAGT:98       Contig00444_left        100.00  98      0       0       1       98      202     105     2e-51    194
#HWI-ST897:147:C0MBGACXX:7:1315:8102:91659:1:N:0:CGTAGT:98       Contig00444_right       100.00  98      0       0       1       98      358     455     2e-51    194

while(<LIST>){
	chomp;
	if(/^(\S+)\s+(\S+)\_\S+\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/){
		my $name1 = $1;
		my $contig1 = $2;

		if ($name1 =~ /^(.*?):(\d):N:/){
			$vash{$1} = $2;
		 push @{$hash{$contig1}}, "$1";
		 #warn "$contig1   $1   $2\n";
		}
	}
}
close LIST;

while(<FILE>){
	chomp;
	if(/^(\S+)\s+(\S+)\_\S+\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/){
		my $name2 = $1;
		my $contig2 = $2;
		if ($name2 =~ /^(.*?):(\d):N:/){
			my $label = $1;
			my $pair = $2;
			#warn "$label    $pair\n";
			if(exists $hash{$contig2}){
				foreach my $ele (@{$hash{$contig2}}){
					if($label eq $ele){
						if($vash{$ele} ne $pair){
							print OUT1 "$contig2\n";
							print OUT2 "$contig2\t$label:$pair\t$ele".":$vash{$ele}\n";
						}
					}
				}
			}
		}
	}
}
close FILE;