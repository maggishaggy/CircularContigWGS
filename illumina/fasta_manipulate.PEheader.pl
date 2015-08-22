#! user/bin/perl -w
#Zhuofei Xu, 2013-04-03
die "Usage: perl $0 fasta.input > out\n" unless (@ARGV == 1);

open (FILE, "$ARGV[0]")||die "cannot open $ARGV[0]\n";

local $/ = '>'; 

my $count = 0;
my $len = 0;
my $name = '';


while (<FILE>){
	chomp;
	my ($head,$sequence) = split(/\n/,$_,2);
	if($head eq '')
	{next;}
	else{$head =~ s/\s/:/;
	$sequence =~ s/\n//g;
  $len = length($sequence);

  print ">$head:$len\n$sequence\n";
 }
}
close (FILE);
        