#! user/bin/perl -w
use strict;
#Zhuofei Xu, 2012-06-20
die "Usage: perl $0 hit.out > plasmid.list\n" unless (@ARGV == 1);

open (FILE, "$ARGV[0]")||die "cannot open $ARGV[0]\n";
my $contig = '';
my %hash = ();

print "ContigID\tNumber_of_reads_cover_end\n";

while (<FILE>){
	chomp;
	  if (/^(\S+)\s+(\S+)\_concatenate/){
	  	$contig = $2;
      $hash{$contig}++;
	}
}
close (FILE);

for my $tag (sort {$a cmp $b} keys %hash){
	print "$tag\t$hash{$tag}\n";
}