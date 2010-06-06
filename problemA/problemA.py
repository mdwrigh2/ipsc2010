#!/usr/bin/env python
# problem - unsort a list :-)

import sys

def parseInputFile(afile):
    """
    Parse an input file for lists
    Return a list of lists
    See Problem A specs for input format.
    """
    lists = [] # list of lists to return

    numCases = int(afile.readline()) # cases to read in
    for i in range(numCases):
        afile.readline() # empty line
        alist = [int(c) for c in afile.readline().split()]
        cases.append( alist ) #append a tuple
    # return a list of cases
    return cases

if __name__ == "__main__":
    # figure out what file to read from
    if len(sys.argv) == 1: # read stdin
        print "Reading stdin as input"
        infile = sys.stdin
    elif len(sys.argv) == 2: # read file
        print "Reading file:", sys.argv[1]
        infile = open(sys.argv[1])
    else:  #len(sys.arvg) > 2:
        print "Usage: ./problemA.py <inputfile>"

    inputs = parseInputFile(infile)
    print inputs
