#!/usr/bin/env python3

"""
cklg: a script to check SAS log files for errors, warnings, and other 
messages that indicate potential problems.

cklg operates on the command line and can process multiple files.
It can be customized for the log messages to find and for the
log messages to ignore. There are only 2 optional command line
parameters, besides the file name(s) to check: give a usage message
and list the strings that will be searched. cklg should be portable
to any system with Python and an available command line.

cklg was intended to work with the Vim editor's quickfix facility. 
Thus, it provides the log file name and the line number of the error 
in addition to the error text. It also can be run as a stand alone
program.

Original Perl version 01JUN2009 by Kent Nassen.
Python version 12/30/2024 by Kent Nassen.
"""

import sys
import re
import argparse
from datetime import datetime

VERSION = f"v1.1, {datetime.now().strftime('%a %b %d %H:%M:%S %Y')}"

# The list of SAS log message strings to search for. Add more here if
# needed. A case-insensitive search will be used.
SEARCH_TERMS = [
    "error",
    "fatal",
    "warning:",
    "syntax error",
    "converted",
    "uninitialized",
    " 0 obs",
    "no obser",
    "repeats of",
    "not found",
    "could not be loaded",
    "w.d. format was too small",
    "not valid",
    "not executed",
    "invalid",
    "overwritten",
    "missing values were generated",
    "outside the axis range",
    "duplicate by var",
    "not created",
    "contained a missing",
    "already sorted",
    "already on the library",
    "ignored",
    "went to new line",
    "no effect",
    "division by zero",
    "stopped",
    "due to loop"
]

# Log messages that look like errors but we don't want to report
IGNORE_PATTERNS = [
    re.compile(r"Errors printed on", re.IGNORECASE),
    re.compile(r"will be automatically converted", re.IGNORECASE)
    # add more messages to skip here
]


def display_usage(prog_name):
    """Display usage message."""
    print(f"""
  {prog_name}: Search SAS logs for errors and warnings
               by Kent Nassen, {VERSION}

   Usage: {prog_name} [filename...]
         -h, --help    Display this usage message
         -l, --list    List the search terms

   Examples: {prog_name} test.log  or  {prog_name} *.log  or  {prog_name} -l
""", file=sys.stderr)
    sys.exit(0)


def list_search_terms(prog_name):
    """List the search terms used by the program."""
    print(f"\nThe log search terms used by {prog_name} are:")
    for term in SEARCH_TERMS:
        print(f"   {term}")
    print(f"\n{len(SEARCH_TERMS)} terms defined.\n")
    sys.exit(0)


def process_file(filename):
    """Process a single log file, looking for errors and warnings."""
    try:
        with open(filename, 'r', encoding='utf-8', errors='replace') as fh:
            for line_number, line in enumerate(fh, start=1):
                # Remove trailing newline and carriage return
                line = line.rstrip('\r\n')
                # Remove overprinted text on the line
                line = re.sub(r'\r.*$', '', line)
                
                # Skip lines matching ignore patterns
                if any(pattern.search(line) for pattern in IGNORE_PATTERNS):
                    continue
                
                # Check if line contains any search terms (case-insensitive)
                line_lower = line.lower()
                if any(term.lower() in line_lower for term in SEARCH_TERMS):
                    print(f"{filename}:{line_number}:{line}")
                    
    except IOError as e:
        print(f"\n   *** cklg.py: Can't open '{filename}': {e}\n", file=sys.stderr)


def main():
    """Main function."""
    prog_name = sys.argv[0].split('/')[-1].split('\\')[-1]
    
    parser = argparse.ArgumentParser(add_help=False)
    parser.add_argument('-h', '--help', action='store_true', 
                        help='Display usage message')
    parser.add_argument('-l', '--list', action='store_true',
                        help='List the search terms')
    parser.add_argument('files', nargs='*', help='Log files to check')
    
    args = parser.parse_args()
    
    # Handle -h option or no files provided
    if args.help or (not args.files and not args.list):
        display_usage(prog_name)
    
    # Handle -l option
    if args.list:
        list_search_terms(prog_name)
    
    # Process each file
    for filename in args.files:
        process_file(filename)


if __name__ == '__main__':
    main()
