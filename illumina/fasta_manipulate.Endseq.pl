#! user/bin/perl
#Zhuofei Xu, 2012-09-11
die "Usage: perl $0 fasta.input (sequence in multi-line) extractLength> out\n" unless (@ARGV == 2);

open (FILE, "$ARGV[0]")||die "cannot open $ARGV[0]\n";
open (OUT1, ">contig.leftseq.fa")||die "cannot open $ARGV[0]\n";
open (OUT2, ">contig.rightseq.fa")||die "cannot open $ARGV[0]\n";

my $right = '';
my $left = '';
my $name = '';

my $len = $ARGV[1];

local $/ = '>';

while (<FILE>){
	chomp;
	my $head = '';
	my $seq = '';
	  ($head,$seq) = split(/\n/,$_,2);
	  if ($head =~ /^(\S+)/){
	  	$name = $1;
		$seq =~ s/\n//g;
		$seq = uc($seq);

		$left = substr($seq,0,$len);
		$right = substr($seq,-($len+1));
    #$right = reverse $right;
		print OUT1 ">$name\_left\n$left\n";
		print OUT2 ">$name\_right\n$right\n";
	}
}
close (FILE);