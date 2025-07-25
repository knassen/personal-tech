#!/usr/bin/perl -w
##---------------------------------------------------------------------------##
##  File:
##      @(#)  freq.pl 1.0 97/05/13 @(#)
##  Author:
##      Kent Nassen     knassen@umich.edu
##  Description:
##      A script for grabbing quick and dirty frequencies
##      from an LRECL data file (vars in fixed column locations)
##
##  Usage:
##      freq.pl [-h] [-c[#-#][#] filename]
##   where: -c#-# indicates starting & ending column numbers of the variable
##          and -c# indicates a single-column variable at column #.
##      
##---------------------------------------------------------------------------##

use Getopt::Std; # use getopt module to parse the command line
$opt_h="";

# Get our name without a path
($ProgName = $0) =~ s%.*/%%;

# Usage message subroutine
sub DisplayUsage {
    print "\nUsage: $ProgName [-h] [-c[#-#][#] filename]\n",
	  "       -c#-#      Start-End column numbers of variable\n",
	  "       -c#        Single column variable at column #\n",
  	  "       filename   LRECL data file filename\n",
	  "       -h         Show this help screen\n",
	  "\n",
	  "       Example: $ProgName -c5-7 fylename.dat\n",
	  "\n       (Column numbers in the file start at column 1)\n\n";
      exit 0;  # all calls to DisplayUsage exit with error code 0...not good
}   # end DisplayUsage

# Get possible options (-c requires a parameter)
getopts (('hc:') || &DisplayUsage); 
&DisplayUsage if ($opt_h);

# Parse the -c option for starting and ending column locations
# (ending location may not be present if the variable is only
# one column wide)
# Note if -c option ends with a hyphen, that will be interpreted as
# another option (filename) since hyphens start options.
if (!$opt_c) { print "\nI need column locations!\n"; 
			&DisplayUsage;
			} # if we don't have an opt_c, no need to go further
$_ = $opt_c;
if (/^([0-9]+)-([0-9]+$)/) { # both starting and ending locations: #-#
	$startcol=$1;
	$endcol=$2;
	}
elsif (/^[0-9]+$/) { # just starting location: #
	$startcol=$opt_c;
	$endcol=$startcol;
	}
else { print "\nI couldn't understand your column location(s)!\n"; 
	&DisplayUsage;
	}

# See if the column locations of the variable make sense
if ($endcol==0 || $startcol==0) {
	print "\nStarting or ending column was zero.\n";
	&DisplayUsage;
	}

# Assume startcol > endcol is a transposition of column locations
# You may want to make this an error instead.
#if ($startcol > $endcol) { # swap startcol and endcol
#	$temp=$endcol; 
#	$endcol=$startcol; 
#	$startcol=$temp; 
#	}

# Set up a string var for printing out hyphenated column locations 
$loc="$startcol"."-"."$endcol";

# What is left on the command is the filename to be processed (hopefully)
if ($#ARGV>0) { print "\nOne filename at a time, please!\n";
		&DisplayUsage;
		}
if ($#ARGV<0) { print "\nI need a filename!\n";
		&DisplayUsage;
		}

# Set up a string var for printing out a quoted filename 
$fname="\"".$ARGV[0]."\"";

#### ---------------------------------------------------- ####
#### Read the data from the file named on the commandline ####
#### ---------------------------------------------------- ####
while (<ARGV>) { 
	chop;   
	# Pull the desired columns and save in data array
	push @data, substr($_,$startcol-1,$endcol-$startcol+1); 
	} # End of data input while loop

#### ---------------------------------------------------- ####
#### The real work begins here                            ####
#### ---------------------------------------------------- ####
# Get Frequencies 
foreach $value (@data) {
	$freq{$value}++;
	}
# Print Out the Frequencies
foreach $value (sort keys(%freq)) {
	$cfreq+=$freq{$value}; # compute cumulative freqs
	write; # this will be formatted by the formats at the end
	}
print "\n";

# Formatted, paged output
format STDOUT_TOP =
 
   @||||@||
   "Page",$%
   @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<@<<<<<<<<<<<<
   "Frequencies for the values in columns",$loc
   @<<<<<<<<<<<@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   "in the file ",$fname
 
                                            Cumulative
                         Value   Frequency   Frequency
                        -------  ---------  ----------
.
format STDOUT =
   @>>>>>>>>>>>>>>>>>>>>>>>>>>>@>>>>>>>>>>@>>>>>>>>>>>
                     $value,   $freq{$value}, $cfreq 
.
