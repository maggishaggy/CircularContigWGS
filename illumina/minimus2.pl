#!/usr/bin/perl
#Zhuofei Xu, April 03, 2013
die "Usage: $0 circularContig" unless (@ARGV == 1);

my $dir = "./"."$ARGV[0]";
opendir(DIR, $dir) || die "Can't open directory $dir\n";
@array = ();
@array = readdir(DIR);

my $name = '';
foreach my $file (@array){
	next unless ($file =~ /^\S+.fa$/);
	if ($file =~ /^(\S+).fa$/){
		$name = $1;
	}
	system ("/usr/local/src/amos-3.1.0-rc1/bin/toAmos -s $dir/$name.fa -o $dir/$name.afg");
	system ("/usr/local/src/amos-3.1.0-rc1/bin/bank-transact -c -z -b $dir/$name.bnk -m $dir/$name.afg");
	system ("/usr/local/src/amos-3.1.0-rc1/bin/dumpreads $dir/$name.bnk -M 1 > $dir/$name.ref.seq");
	system ("/usr/local/src/amos-3.1.0-rc1/bin/dumpreads $dir/$name.bnk -m 1 > $dir/$name.qry.seq");
	system ("/usr/local/bin/nucmer -maxmatch -c 40 $dir/$name.ref.seq $dir/$name.qry.seq -p $name");
	system ("mv $name.delta $dir/");
	system ("/usr/local/bin/show-coords -H -c -l -o -r -I 94 $dir/$name.delta \| /usr/local/src/amos-3.1.0-rc1/bin/nucmerAnnotate \| egrep 'BEGIN|END|CONTAIN|IDENTITY' > $dir/$name.coords");
	system ("/usr/local/src/amos-3.1.0-rc1/bin/nucmer2ovl -ignore 20 -tab $dir/$name.coords \| /usr/local/src/amos-3.1.0-rc1/bin/sort2 > $dir/$name.ovl");
	system ("/usr/local/src/amos-3.1.0-rc1/bin/ovl2OVL $dir/$name.ovl > $dir/$name.OVL");
	system ("rm -f $dir/$name.bnk/OVL.*");
	system ("/usr/local/src/amos-3.1.0-rc1/bin/bank-transact -z -b $dir/$name.bnk -m $dir/$name.OVL");
	system ("/usr/local/src/amos-3.1.0-rc1/bin/tigger -b $dir/$name.bnk");
	system ("/usr/local/src/amos-3.1.0-rc1/bin/make-consensus -B -e 0.06 -b $dir/$name.bnk -w 15");
	system ("/usr/local/src/amos-3.1.0-rc1/bin/bank2contig $dir/$name.bnk > $dir/$name.contig");
	system ("/usr/local/src/amos-3.1.0-rc1/bin/bank2fasta -b $dir/$name.bnk > $dir/$name.fasta");
}
closedir (DIR);



