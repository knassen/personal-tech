#!/usr/bin/env perl

# Wrapit: Read input or data list statements (e.g. "VAR1 12-18 .4", one
# line at a time and output them in wrapped format, five to a line
#  Kent Nassen, 4/22/97 & 8/15/97

# Sample input:
#  V1 1-4
#  V2 5-8
#  V3 9-9
#  V4 10-13
#  V5 14-14
#  V6 15-16
#  V7 17-17
#  V8 18-19
#  V9 20-21

# Sample output:
#   V1 1-4                   V2 5-8                   V3 9-9                   
#   V4 10-13                 V5 14-14                 V6 15-16                 
#   V7 17-17                 V8 18-19                 V9 20-21

# Read the input statements into an array
while (<>) {           # read from file on commandline
  chop;                # drop line ends
  for ($_) { s/^\s+//; s/\s+$//; } # strip leading & trailing blanks
  push @elements, $_;  # build array
  }

# Print out the array elements in preferred order & format
   for ($i=0; $i<=$#elements; $i+=5) {  # we want a 5-wide listing
      printf("   %-15s%-15s%-15s%-15s%-s\n",${elements}[$i],${elements}[$i+1],
		${elements}[$i+2],${elements}[$i+3],${elements}[$i+4]); 
   }

