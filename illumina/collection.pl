#!/usr/bin/perl
#Zhuofei Xu, April 03, 2013
die "Usage: $0 circularContig(Dir) > circularcontig.fna" unless (@ARGV == 1);

my $dir = "./"."$ARGV[0]";
opendir(DIR, $dir) || die "Can't open directory $dir\n";
@array = ();
@array = readdir(DIR);

my $name = '';
foreach my $file (@array){
	next unless ($file =~ /^\S+.fasta$/);
	if ($file =~ /^(\S+).fasta$/){
		$name = $1;
	}
	open (FILE, "$dir/$file")||die "can't open file:$!\n";
	while(<FILE>){
		chomp;
		if (/^$/){next;}
		if(/^>/){
			print ">$name\n";
		}elsif(/^\S+$/){
			print "$_\n";
		}
	}
	close FILE;
}
closedir (DIR);



