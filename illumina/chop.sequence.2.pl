#!/usr/bin/perl -w
use strict;
#Zhuofei Xu, April 03, 2013
die "Usage: perl $0 contig.fna \n" if(@ARGV != 1);

my $dir = "./"."chopContig";
 system("mkdir chopContig");
 
use Bio::SeqIO;

my $input = shift @ARGV;
my $in = new Bio::SeqIO(-format => 'fasta', -file => "$input");
my $count = 0;
my $len = 0;
my $middle = 0;
my $left = '';
my $right = '';
my $name = '';

while( my $seq = $in->next_seq ) {
	$count++;
	$name = $seq->id;
	$len = $seq->length;
	$middle = int($len/2);
	$left = $seq->subseq(1,100);
	$right = $seq->subseq(($len-99),$len);
	open (OUT, ">$dir/$name.fa")|| die "can't open file:$!\n";
	print OUT ">$name.left.sequence\n$left\n>$name.right.sequence\n$right\n";
}

