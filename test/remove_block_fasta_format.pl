#!/usr/local/bin/perl -w
#remove_block_fasta_format.pl
#Geoffrey Hannigan
#Elizabeth Grice Lab
#University of Pennsylvania
#Major help from Qi Zhang :)

# Set use
use strict;
use warnings;

my $IN;
my $OUT;

# Set files to scalar variables
my $usage = "Usage: perl $0 <INFILE> <OUTFILE>";
my $infile = shift or die $usage;
my $outfile = shift or die $usage;
open($IN, "<", "$infile") || die "Unable to open $infile: $!";
open($OUT, ">", "$outfile") || die "Unable to write to $outfile: $!";

#Set variables to be used later in script
my $flag = 0;

while (my $line = <$IN>) {
	#If the line is a fasta title line (starts with arrow)
	if ($line =~ /\>/) {
		print $OUT "\n" if ($flag);
		$flag=1;
	}
	else {
		chomp $line;
	}
		print $OUT $line;
}
# Print the final newline
print $OUT "\n";

#Close out files and print completion note to STDOUT
close($IN);
close($OUT);
print "Completed\n"
