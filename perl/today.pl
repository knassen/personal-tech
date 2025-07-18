#!/usr/um/bin/perl
#
# today - print a calendar with today in reverse video (vt100 hardcoded)
# (Handy for a login script)
#
#                               April 1999                               
#                             S  M Tu  W Th  F  S                        
#                                         1  2  3                        
#                             4  5  6  7  8  9 10                        
#                            11 12 13 14 15 16 17                        
#                            18 19 20 21 22 23 24                        
#                            25 26 27 28 29 30                           
#                                                                        
#                          Current time is:  7:02 PM

use vars qw( $min $hour $mday $mon $year $current_line $len );

($min,$hour,$mday,$mon,$year) = (localtime)[1,2,3,4,5];
$mon++;
$year+=1900;

open ( CALENDAR, "/usr/bin/cal $mon $year |" );

print "\n";
until (eof(CALENDAR)) {
    chop($current_line = <CALENDAR>);
    $len = 22;
    $current_line =~ s/\b$mday\b/\033[7m$mday\033[m/;
    printf (sprintf("                            %%-20s  %%-%ds\n", $len), $current_line );
}
printf("\n                          Current time is: %2d:%02d %s\n\n",
        ($hour>12 ? $hour-12 : $hour),$min,($hour>=12 ? "PM" : "AM"));
