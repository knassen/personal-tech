#!/usr/bin/env python3

"""
Replace tabs with spaces.

This program replaces tabs with spaces, supporting two modes:
- column: spaces to the next tab stop (default)
- literal: fixed number of spaces per tab

Ported from detab.pl by Kent Nassen, originally v1.0 (5/5/1999)
Python version by Kent Nassen, 3/8/2026
"""

import sys
import argparse


def detab_literal(line, tablen):
    """Replace each tab with a fixed number of spaces."""
    return line.replace('\t', ' ' * tablen)


def detab_column(line, tablen):
    """Replace each tab with spaces to the next tab stop."""
    result = []
    pos = 0
    for char in line:
        if char == '\t':
            # Calculate spaces needed to reach next tab stop
            spaces = tablen - (pos % tablen)
            result.append(' ' * spaces)
            pos += spaces
        else:
            result.append(char)
            if char == '\n':
                pos = 0
            else:
                pos += 1
    return ''.join(result)


def main():
    parser = argparse.ArgumentParser(
        prog='detab',
        description='Replace tabs with spaces, Kent Nassen 3/8/2026'
    )
    parser.add_argument(
        '-l', '--length',
        type=int,
        default=8,
        help='Each tab is worth up to this many spaces (default: 8)'
    )
    parser.add_argument(
        '-m', '--mode',
        choices=['column', 'literal'],
        default='column',
        help='Tab replacement mode (default: column)'
    )
    parser.add_argument(
        'filename',
        nargs='?',
        help='Input file (default: stdin)'
    )

    args = parser.parse_args()

    if args.length <= 0:
        print(f"\n   *** Bad tab length: {args.length}", file=sys.stderr)
        sys.exit(1)

    # Choose the detab function based on mode
    if args.mode == 'literal':
        detab_func = detab_literal
    else:  # column
        detab_func = detab_column

    # Open input file or use stdin
    if args.filename:
        try:
            input_file = open(args.filename, 'r')
        except IOError as e:
            print(f"\n   *** Error opening file: {e}", file=sys.stderr)
            sys.exit(1)
    else:
        input_file = sys.stdin

    # Process lines
    try:
        for line in input_file:
            detabbed = detab_func(line, args.length)
            # Only print if line contains non-tab characters
            if any(c != '\t' for c in line):
                sys.stdout.write(detabbed)
    finally:
        if args.filename:
            input_file.close()


if __name__ == '__main__':
    main()
