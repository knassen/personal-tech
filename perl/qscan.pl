#!/usr/bin/env perl
#  qscan.pl (quote scan)
#  A script to count the characters between pairs of double quote marks ("")
#    on lines from a text file, as in SPSS VARIABLE LABELS and VALUE
#    LABELS statements.
#
#  Kent Nassen, v1.0: 2/14/95 (first version, called 40scan)
#      v1.1: 2/16/98 -- added multiple file capability, test for file
#                       existence, and a length variable ($checklen) so
#                       that changing the length to check for is easier.
#      v1.2: 5/12/98 -- added message to print when no long quotes are found.
#      v1.3: 8/20/98 -- fixed longlines count, added message with count of #
#                       of longlines, changed all references to 40 to
#                       $checklen in anticipation of adding a commandline
#                       length option.
#      v1.4: 9/03/98 -- Added formatted output (page numbers, headers,
#                       etc.) to make printing long lists easier.
#      v1.5: 9/22/98 -- Improved output formatting a bit (number of lines
#                       in file, line number of longest quoted text, page
#                       header). Each file's output now starts on a new page.
#      v1.6: 6/27/99 -- Improved handling of files with no quoted lines or
#                       with quoted lines, but no long quoted lines. Set
#                       output to truncate when the contents of the
#                       line pushes total width over 80 chars.  Moved
#                       *** messages to print in the body of the report
#                       rather than in the summary. Should print a nicer
#                       looking report now.  Added -l option to set the
#                       quoted string length to be searched. Changed name
#                       to qscan.
#      v1.7: 8/15/99 -- Am setting format_page_number to 0 at the start of
#                       each file, so that each file's report is numbered
#                       from page 1 (since it is likely each would be seen
#                       as separate reports). To undo this change, comment
#                       out or remove the line: 
#                       STDOUT->format_page_number(0); # Each file starts with Page 1
#     v1.8: 10/22/99 -- Added support for also finding single-quoted strings.
#     v1.9:  9/16/25 -- Updated to lexical filehandles.
#
#
#  :set tabstop=4
#
#  SYNTAX:  qscan filename[...]
#use warnings;
#use strict;

use Getopt::Std;

our ($version, $checklen, $pagesize, $ProgName, $lines, $testcount, 
    $maxcount, $longlines, $extendlen, $filename, $input, $extend, $maxline,
 	$lentest, $opt_l, $CurrentFile );

# $version="v1.1, 2/16/98";
# $version="v1.2, 5/12/98";
# $version="v1.3, 8/20/98";
# $version="v1.4, 9/03/98";
# $version="v1.5, 9/22/98";
# $version="v1.6, 6/27/99";
# $version="v1.7, 8/14/99";
#$version="v1.8, 10/22/99";
$version="v1.9, 9/16/25";

# NOTE: $checklen sets the length of quoted text to search for
my $file="", $checklen=40, $pagesize=54;
STDOUT->format_lines_per_page($pagesize);

($ProgName = $0) =~ s%.*/%%;  # Unix
#($ProgName = lc $0) =~ s%.*\\%%;  # DOS

$opt_l='';

getopt('l:');

if ($opt_l =~ /^\d+$/) { $checklen=$opt_l }
else { if ($opt_l) { print STDERR "\n   *** -l parameter, $opt_l, is not a number\n"; &DisplayUsage; 
	exit 1;
	}
}

if ($#ARGV<0) {
    &DisplayUsage;
    exit 1;
}

foreach my $file (@ARGV) {
	STDOUT->format_page_number(0); # Each file starts with Page 1
    open my $fh, '<',$file or do {
       warn"\n   *** $ProgName: Can't open '$file': $!\n\n";
       next;
   };
	process($fh, $file);
}

sub process {
	my ($fh, $filename) = @_;
    $lines=$testcount=$maxcount=$longlines=0;
	$extend=" ";
    $CurrentFile=$filename;
	$extendlen=56; # length beyond which we truncate long strings in the output
	$input++;
	while (<$fh>) {
		chop;
        $lines++;
		if ( m/".*?".*(".*?")/ or m/'.*?'.*('.*?')/ ) {
			$testcount=length($1);
			if ( $testcount>$checklen ) {
				$longlines++;
				$lentest=length($_);
				if ($lentest>=$extendlen) { $extend='...' }
				else { $extend=" " }
				write;
			}
            if ($testcount>$maxcount) { $maxcount=$testcount; $maxline=$.; }
			$extend="";
		}
		if ( m/"(.*?)"/ or m/'(.*?)'/ ) {
			$testcount=length($1);
			if ( $testcount>$checklen ) {
				$longlines++;
				$lentest=length($_);
				if ($lentest>=$extendlen) { $extend='...' }
				else { $extend=" " }
				write;
			}
            if ($testcount>$maxcount) { $maxcount=$testcount; $maxline=$.; }
		}
	} # end of while (file has been completely read and processed)

	# Print out summary information about the file and set up for a new page on next file
   	if (!$longlines) { # No long lines found
        if (!$maxcount) { $_=" *** No quoted text found.\n"; }
        else { # Quoted text found, but not over the max
            $testcount="";
		    $_=" *** No quoted text over $checklen characters long.\n";
        }
        my $CurrentFile=$filename;
        print $CurrentFile,"\n";
		write; # Print out the header for files with no lines over max
        if ($lines==1) { print "\n    There was one line in the '$filename'\n"; }
        else { print "\n    There were $lines lines in '$filename'\n"; }
        if ($maxcount) { # Quoted text over the max found
            print "    The length of the longest quoted text found was $maxcount",
				" characters at line $maxline.\n";
        }
	}
	else { # Long quoted text found
        if ($lines==1) { print "\n    There was one line line in the '$filename'.\n"; }
        else { print "\n    There were $lines lines in '$filename'\n"; }
        if ($longlines==1) {
		    print "    One line had quoted text over $checklen characters long.\n";
        }
        else {
		    print "    $longlines lines had quoted text over $checklen characters long.\n";
        }
           print "    The length of the longest quoted text found was $maxcount",   
                           " characters at line $maxline.\n";                       
           }                                                                        
           print "\n";                                                              
           close $fh;                                                            
           STDOUT->format_lines_left("0");                                          
   } # end of subroutine process()                                                  

sub DisplayUsage {
    print STDERR "\n  $ProgName: Find long quoted text",
			" (e.g., check the length of variable\n";
    print STDERR "               and value labels).  by Kent Nassen, $version\n";

    print STDERR "\n   Usage: $ProgName [-l#] [filename...]\n",
          "        -l#  number of characters within quotes to search for (default=40)\n\n",
		  "        (multiple filenames or wildcards are accepted if your shell\n",
          "        can handle them)\n",
          "\n",
          "   Examples: $ProgName sp6360.sps  or  $ProgName -l60 *.sps\n\n";
}

format STDOUT_TOP =

   @||||@||
   "Page",$%

   @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   "$ProgName: Find long quoted text";
   @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   "by Kent Nassen, $version";
   Scanning for quoted text longer than @< characters in the file @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   $checklen, $CurrentFile

             Quote
   Line#     Length                   Line Contents/*** Message
  -------   --------  ----------------------------------------------------------
.

format STDOUT =
  @>>>>>> @>>>>>>>>   @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<@<<<
$.,$testcount,$_,$extend
.
