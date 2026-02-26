#!/usr/bin/env python3

"""
freq2.py: compute frequencies for a single variable in an
    LRECL data file. Also computes cumulative frequencies,
    percentages, and cumulative percentages.
    
Original Perl version by Kent Nassen (v1.2, 2/07/99)
Python version by Kent Nassen 2/24/2026

Usage:
    freq2.py [-h] [-c COLUMNS] filename
    
    -c#-#      Start-End column numbers of variable
    -c#        Single column variable at column #
    filename   LRECL data file filename
    -h         Show this help screen
    
    Example: freq2.py -c5-7 filename.dat
    
    (Column numbers in the file start at column 1)

Limitations:
    - Can only print the first 20 characters of a value,
      although can compute frequencies for longer values.
    - The order of values in the output is set by a character
      sort rather than a numeric sort (the program knows
      nothing of variable types like numeric or string).
    - If you give a column range outside the logical record
      length of the data, you will still get output, but all
      values will be null.
"""

import sys
import argparse
import re
from collections import defaultdict


def display_usage(prog_name):
    """Display usage message and exit."""
    print(f"""
   *** I need column locations!

{prog_name}: compute frequencies for a single variable in an
    LRECL data file. Also computes cumulative frequencies,
    percentages, and cumulative percentages.
    --Kent Nassen (v1.2, 2/07/99)

Usage: {prog_name} [-h] [-c[#-#][#] filename]
       -c#-#      Start-End column numbers of variable
       -c#        Single column variable at column #
       filename   LRECL data file filename
       -h         Show this help screen

       Example: {prog_name} -c5-7 fylename.dat

       (Column numbers in the file start at column 1)
""", file=sys.stderr)
    sys.exit(1)


def parse_columns(col_spec):
    """
    Parse column specification.
    Returns (start_col, end_col) tuple (1-based indexing).
    """
    if not col_spec:
        return None, None
    
    # Check for range format: #-#
    match = re.match(r'^(\d+)-(\d+)$', col_spec)
    if match:
        start_col = int(match.group(1))
        end_col = int(match.group(2))
        return start_col, end_col
    
    # Check for single column format: #
    match = re.match(r'^(\d+)$', col_spec)
    if match:
        col = int(match.group(1))
        return col, col
    
    return None, None


def print_header(page_num, loc, fname):
    """Print page header."""
    print()
    print(f"   Page {page_num:02d}")
    print(f"   Frequencies for the values in columns {loc}")
    print(f"   in the file \"{fname}\"")
    print()
    print("                                           Cumulative  Cumulative")
    print("               Value   Frequency  Percent   Frequency     Percent")
    print("              -------  ---------  -------  ----------  ----------")


def print_frequencies(freq_dict, filename, loc, pagesize=57):
    """Print formatted frequency table with pagination."""
    if not freq_dict:
        print("\nNo data found.")
        return
    
    total_cases = sum(freq_dict.values())
    cumulative_freq = 0
    page_num = 1
    line_count = 0
    
    # Print first page header
    print_header(page_num, loc, filename)
    line_count = 7  # Header uses 7 lines
    
    # Sort keys - try numeric sort first, fall back to string sort
    try:
        sorted_keys = sorted(freq_dict.keys(), key=lambda x: float(x) if x.strip() else float('inf'))
    except (ValueError, TypeError):
        sorted_keys = sorted(freq_dict.keys())
    
    for value in sorted_keys:
        # Check if we need a new page
        if line_count >= pagesize:
            page_num += 1
            print_header(page_num, loc, filename)
            line_count = 7
        
        freq = freq_dict[value]
        cumulative_freq += freq
        
        # Calculate percentages
        if total_cases > 0:
            freq_pct = (freq / total_cases) * 100
            cumulative_pct = (cumulative_freq / total_cases) * 100
        else:
            freq_pct = 0
            cumulative_pct = 0
        
        # Truncate value to 20 characters for display
        display_value = value[:20] if len(value) > 20 else value
        
        # Print formatted line
        print(f"{display_value:>20} {freq:>9}  {freq_pct:>7.2f}  {cumulative_freq:>10}     {cumulative_pct:>7.2f}")
        line_count += 1
    
    print()


def main():
    """Main function."""
    prog_name = sys.argv[0].split('/')[-1].split('\\')[-1]
    
    # Custom argument parser to handle the specific format
    parser = argparse.ArgumentParser(
        add_help=False,
        description='Compute frequencies for LRECL data files'
    )
    parser.add_argument('-h', '--help', action='store_true',
                        help='Show help message')
    parser.add_argument('-c', dest='columns', type=str,
                        help='Column specification (e.g., 5-7 or 5)')
    parser.add_argument('filename', nargs='?',
                        help='LRECL data file to process')
    
    args = parser.parse_args()
    
    # Handle help
    if args.help or not args.columns:
        display_usage(prog_name)
    
    # Parse column specification
    start_col, end_col = parse_columns(args.columns)
    
    if start_col is None or end_col is None:
        print("\n   *** I couldn't understand your column location(s)!\n", file=sys.stderr)
        display_usage(prog_name)
    
    # Validate column numbers
    if start_col == 0 or end_col == 0:
        print("\n   *** Starting or ending column was zero.\n", file=sys.stderr)
        display_usage(prog_name)
    
    # Swap if start > end
    if start_col > end_col:
        start_col, end_col = end_col, start_col
        print("\n   *** Start col greater than end col: assuming reversed col. locations.\n",
              file=sys.stderr)
    
    # Check for filename
    if not args.filename:
        print("\n   *** I need a data filename!\n", file=sys.stderr)
        display_usage(prog_name)
    
    # Create location string for display
    loc = f"{start_col}-{end_col}"
    
    # Read data file and extract column values
    freq_dict = defaultdict(int)
    
    try:
        with open(args.filename, 'r', encoding='utf-8', errors='replace') as f:
            for line in f:
                line = line.rstrip('\n\r')
                # Extract substring (convert to 0-based indexing)
                value = line[start_col-1:end_col] if len(line) >= start_col else ''
                freq_dict[value] += 1
    except IOError as e:
        print(f"\n{prog_name}:   *** Can't open data file '{args.filename}': {e}\n",
              file=sys.stderr)
        sys.exit(1)
    
    # Print frequency table
    print_frequencies(freq_dict, args.filename, loc)


if __name__ == '__main__':
    main()
