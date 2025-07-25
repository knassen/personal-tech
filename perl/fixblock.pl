#!/opt/gnu/bin/perl
#
# fixblock.pl -- block a data file to a fixed record length
#
#   This program is for fixing a data file that has no lineends, but
#   is supposed to be LRECL. Such data files often come from tape as
#   "stream files". The program reads records of LRECL-length and writes
#   them to a new file, with lineends.  Other programs that perform a
#   similar task are dd (difficult to use) and fold (doesn't put a line
#   end on the last line).
#
#   Note: most of this program is pretty-printing error and
#   usage messages.  The actual working code is one line of Perl
#   (while/sysread).  Tested with 'use strict' and -w.
#
#   --Kent Nassen, 11/30/95, 3/12/97, 8/12/98, and 9/22/98

# Syntax:  fixblock.pl -l# infile outfile
#    where # is the lrecl number of characters to block the file
#    All parameters on the command line are required.

use Getopt::Std;
use vars qw($version $ProgName $infile $outfile $recnum $record $opt_l);

# $version="(v1.3, 8/12/98)";
$version="(v1.4, 9/22/98)";
($ProgName = $0) =~ s%.*/%%; # Unix
# ($ProgName = lc $0) =~ s%.*\\%%; # DOS 

getopts('l:');
if (!$opt_l) { 
    &UsageInfo; 
	print STDERR "   *** No -l (record length) parameter given\n\n";
    exit 1;
}
if ($#ARGV > 1) {
    &UsageInfo; 
    print STDERR "   *** Input and output are the only filenames allowed\n\n";
    exit 1;
}
if ($#ARGV==1) { $infile = $ARGV[0]; $outfile = $ARGV[1]; }
else { 
    &UsageInfo; 
    print STDERR "   *** Input and output filenames are both required\n\n";
    exit 1;
}

# Open the files, read records, and write blocked output
open INDAT, "<$infile" or 
    die "\n   *** $ProgName: Can't open input file '$infile': $!\n\n";
open OUTDAT, ">$outfile" or 
    die "\n   *** $ProgName: Can't open output file '$outfile': $!\n\n";

while (sysread(INDAT, $record, $opt_l)) { $recnum++; print OUTDAT $record,"\n"; }

close INDAT;
close OUTDAT;
print STDERR "\n$ProgName: Done!\n",$recnum," records processed from '$infile'\n\n",
"Output is in '$outfile'\n\n";

sub UsageInfo {
	print STDERR "\n$ProgName: block a data file that has no lineends ",
            "(inserts a lineend after\n    a given number of characters) ",
            "--Kent Nassen ", $version,"\n\n   Usage: $ProgName -l# infile outfile\n",
            "       where # is the record length desired\n\n",
            "       For example:\n",
            "       $ProgName -l80 mydata mydata.out\n\n"; 
}
