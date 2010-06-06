#!/usr/bin/env python
# problemB - find the shortest path between two points,
#   using an integer grid, and a single diagonal line
import sys

def parseInputFile(afile):
    """
    Parse an input file for test cases.
    Return a list of test cases.
    See Problem B specs for input format.
    """
    cases = [] # list to return

    numCases = int(afile.readline()) # cases to read in
    for i in range(numCases):
        afile.readline() # empty line
        aline = afile.readline()
        ax,ay,bx,by,p,q,r = aline.split()
        ax,ay,bx,by = int(ax),int(ay),int(bx),int(by)
        p,q,r = float(p),float(q),float(r)
        cases.append( (ax,ay,bx,by,p,q,r) ) #append a tuple
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
        print "Usage: ./problemB.py <inputfile>"

    inputs = parseInputFile(infile)
    print inputs
