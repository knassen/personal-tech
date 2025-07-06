#!/usr/um/bin/perl
# ad-counter.pl
# written 5-16-96 by Jackie Hamilton (kira@metronet.com)
#
# This cgi increments a counter in a file, then returns a gif image.
# This is good for use as a "hidden" counter within a page.
#
# Note: be sure that the counter file is set WRITABLE by the httpd
# daemon owner or group.  in Unix you'll need to 'chmod 775 countfile'
# or possibly 'chmod 775 countfile'.
#
# You should substitute the value for "gradeline.gif" with the name of
# whatever gif image you want returned after the counter runs.
#

$countfile = "./cgicount";
$giffile = "gif/bsddaem5.gif";

# Increment the counter file.
$count = `cat $countfile`;
chop($count);
$count = $count + 1;
open(INF,">$countfile");
print INF "$count\n";
close(INF);

# Print out the image.
print "Content-type:image/gif\n\n";
@gifdata = `cat $giffile`;
print @gifdata;

# the end.
