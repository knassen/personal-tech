#!/usr/um/bin/perl

# ----------------------------------------------------------------------
#
# simplehits.pl
#
# a simple printed text hit counter using Server Side Includes (SSI)
# or can be used as a graphical HIDDEN counter using <img src> html
# tag to call. Make copies with different names and hit files for
# use on different pages.
#
# version 1.01 February 25th 1997
#
# Jeremy Rodwell, CGI Magic
# http://www.spells.com/cgi
# users@spells.com
#
# change the variable paths for $hit_file and $gif to suit your server
#
# put simplehits.pl in your cgi-bin and CHMOD it 755.
#
# ----------------------------------------------------------------------

# --- set the user variables

#$type = "text";  	# "text" for text output SSI counter  
$type = "hidden"; 	# "hidden" for a hidden <img src> counter
			# Unhash ONLY ONE at a time

$hit_file = "../data/simplehits.txt";

$gif =	"http://www-personal.umich.edu/~knassen/gif/simplehits.gif";
#$gif =	"../gif/simplehits.gif";

# --- no more user variables to set

$lock = 2;
$unlock = 8;

# --- run the program

# --- output MIME header for text counter

	if ($type eq "text") {
		print "Content-type: text/plain", "\n\n";

# --- or output no header for Server Redirection of graphics

	} elsif ($type eq "hidden") {

	}

# --- open FILE for reading and lock it

	if (open (FILE, "<" . $hit_file)) {
		flock (FILE, $lock);

# --- read the hits file
	
    		$hits = <FILE>;

# --- unlock and close FILE

		flock (FILE, $unlock);
    	close (FILE);

# --- open FILE for writing and lock it

    	if (open (FILE, ">" . $hit_file)) {
		flock (FILE, $lock);

# --- increment the hits count

        	$hits++;

# --- write new hit count to FILE

        	print FILE $hits;

# --- unlock and close FILE

		flock (FILE, $unlock);
        close (FILE);

# --- print the current hit count to STDOUT

	if ($type eq "text") {
        	print $hits;

# --- or use Server Redirection to output the "hidden graphic"

	} elsif ($type eq "hidden") {
      		print "Location:  $gif\n\n";
	}

# --- print error message if FILE cannot be read from / written to

    	} else {
        	print "[Can't write to the data file $hit_file!]", "\n";
    	}

	} else {
    		print "[Can't read from the data file $hit_file!]", "\n";
	}

# --- and end the program

exit (0);
