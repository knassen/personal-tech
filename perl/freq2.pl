#!/usr/bin/perl
##---------------------------------------------------------------------------##
##  File:
##      @(#)  freq2.pl 1.2 99/02/07 @(#)
##  Author:
##      Kent Nassen     knassen@umich.edu
##  Description:
##      A program for grabbing quick and dirty univariate frequencies
##      from an LRECL data file (vars in fixed column locations). Useful
##      if you just want to see what's in a column range without having
##      to fire up SAS or SPSS.
##
##  Usage:
##      freq.pl [-h] [-c[#-#][#] filename]
##   where: -c#-# indicates starting & ending column numbers of the variable
##          and -c# indicates a single-column variable at column #.
##          -h gives a help screen.
##          Only one filename may be given.
##
##  Limitations:
##        - Can only print the first 20 characters of a value,
##          although can compute frequencies for longer values.
##        - The order of values in the output is set by a character
##          sort rather than a numeric sort (the program knows
##          nothing of variable types like numeric or string).
##        - If you give a column range outside the logical record
##          length of the data, you will still get output, but all
##          values will be null.
##
##  v1.1: Added computation of percentages (7/4/1997)
##  v1.2: Checked with -w and 'use strict'.  Improved error handling.
##        Fixed number of lines per page in output. (2/7/1999)
##      
##---------------------------------------------------------------------------##
#use warnings;
#use strict;

use Getopt::Std;

our ($opt_h, $ProgName, $opt_c, $temp, $loc, $fname, 
     $nofcases, $startcol, $endcol, $cfreq, $value, 
     $cfreqpct, $valuepct, $freqpct, @data, %freq,
     $transpos, $version, $pagesize);

$pagesize=57;
STDOUT->format_lines_per_page($pagesize);

# Check performance
#my $begint = (times) [0];

$version="(v1.2, 2/07/99)";

#$opt_h="";

($ProgName = $0) =~ s%.*/%%;  # Unix
#($ProgName = lc $0) =~ s%.*\\%%;  # DOS

# Usage message subroutine
sub DisplayUsage {
    print STDERR "\n$ProgName: compute frequencies for a single variable in an\n",
      "    LRECL data file. Also computes cumulative frequencies\,\n",
      "    percentages\, and cumulative percentages.\n",
      "    --Kent Nassen $version\n",
      "\nUsage: $ProgName [-h] [-c[#-#][#] filename]\n",
	  "       -c#-#      Start-End column numbers of variable\n",
	  "       -c#        Single column variable at column #\n",
  	  "       filename   LRECL data file filename\n",
	  "       -h         Show this help screen\n",
	  "\n",
	  "       Example: $ProgName -c5-7 fylename.dat\n",
	  "\n       (Column numbers in the file start at column 1)\n\n";
      exit 1;
}

# Get possible options (-c requires a parameter)
getopts (('hc:') or &DisplayUsage); 

# -h option?
if ($opt_h) { &DisplayUsage };

# Parse the -c option for starting and ending column locations
#  (ending location need not be present if the variable is only
#  one column wide, e.g. -c5)
if (!$opt_c) { print STDERR "\n   *** I need column locations!\n"; 
			&DisplayUsage;
			} # if we don't have an opt_c, no need to go further
$_ = $opt_c;
if (/^([0-9]+)-([0-9]+$)/) { # both starting and ending locations: #-#
	$startcol=$1; $endcol=$2;
	}
elsif (/^[0-9]+$/) { # just starting location: #
	$startcol=$opt_c; $endcol=$startcol;
	}
else { print STDERR "\n   *** I couldn't understand your column location(s)!\n"; 
	&DisplayUsage;
	}

# See if the column locations of the variable make sense
if ($endcol==0 || $startcol==0) {
	print STDERR "\n   *** Starting or ending column was zero.\n";
	&DisplayUsage;
	}

# Assume startcol > endcol is a transposition of column locations
# You may want to make this an error instead.
if ($startcol > $endcol) { # swap startcol and endcol
	$temp=$endcol; $endcol=$startcol; $startcol=$temp; 
    print STDERR "\n   *** Start col greater than end col: assuming reversed col. locations.\n";
    }

# Set up a string var for printing out hyphenated column locations 
# (rather than construct this for each page printed)
$loc="$startcol"."-"."$endcol";

# What is left on the command is the filename to be processed (hopefully)
if ($#ARGV>0) { print STDERR "\n   *** One filename at a time, please!\n";
		&DisplayUsage;
		}
if ($#ARGV<0) { print STDERR "\n   *** I need a data filename!\n";
		&DisplayUsage;
		}
open INFILE, "<$ARGV[0]" or die "\n$ProgName:   *** Can't open data file '$ARGV[0]': $!\n\n";

# Set up a string var for printing out a quoted filename 
#  (rather than construct this for each page printed)
$fname="\"".$ARGV[0]."\"";

#### ---------------------------------------------------- ####
#### Read the data from the file named on the commandline ####
#### ---------------------------------------------------- ####
while (<ARGV>) { chop;   
	# Pull the desired columns and save in data array
	push @data, substr($_,$startcol-1,$endcol-$startcol+1); 
	}

#### ---------------------------------------------------- ####
#### The real work begins here                            ####
#### ---------------------------------------------------- ####
# Accumulate Frequencies 
$nofcases=$cfreq=0;
foreach $value (@data) { $freq{$value}++; $nofcases++; }

# Print Out the Frequencies
foreach $value (sort { $a <=> $b } keys(%freq)) {
	$cfreq=$cfreq+$freq{$value}; # cumulative freqs
	if ($nofcases) { $cfreqpct=($cfreq/$nofcases)*100 } # cumulative percent
		else { $cfreqpct="----" } # don't divide by zero
	if ($nofcases) {$freqpct=($freq{$value}/$nofcases)*100;} # value percent
		else { $freqpct="----" }
	write; # this will be formatted by the formats at the end
	}
print "\n";
close INFILE;

# Check performance
#my $endt = (times)[0];
#printf("\n Preceding task required %.2f seconds CPU time\n",$endt-$begint);

# Formatted, paged output
format STDOUT_TOP =
 
   @||||@||
   "Page",$%
   @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<@<<<<<<<<<<<<
   "Frequencies for the values in columns",$loc
   @<<<<<<<<<<<@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   "in the file ",$fname
 
                                           Cumulative  Cumulative
               Value   Frequency  Percent   Frequency     Percent
              -------  ---------  -------  ----------  ----------
.
format STDOUT =
@>>>>>>>>>>>>>>>>>>> @>>>>>>>>>  @###.##  @>>>>>>>>>     @###.##
$value,$freq{$value},$freqpct,$cfreq,$cfreqpct 
.
