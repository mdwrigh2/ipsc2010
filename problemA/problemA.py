#!/usr/bin/env python
# problem - unsort a list :-)

import sys

def unSort(alist):
    """
    unSort a list of numbers, make a list of numbers
    be NOT sorted in either ascending or descending
    order.
    Returns a list of the same numbers, unsorted
    """
    # copy the list
    l = list(alist)
    # reject unsolvable case. this shouldnt happen
    if len(l) < 3:
        print "Error: got a list with less than 3 items"
        return None
    # scan for the first three items,
    # two of which must be distinct
    a,b,c = None,None,None
    for i in xrange(len(l)):
        if a is None:
            a = i
            continue
        if b is None:
            b = i
            continue
        if c is None:
            if l[a] != l[b] or (l[b] != l[i] and l[a] != l[i]):
                c = i
                break
            else:
                continue
    # check that we got our requirement
    if c is None:
        print "Error: didn't get 3 items w/ 2 distinct numbers"
        return None
    # Reorder the items
    ### IF WE GOT TWO OF THEM THE SAME
    if l[a] == l[b]:
        l[a],l[b],l[c] = l[a],l[c],l[b]
        return l
    if l[a] == l[c]:
        l[a],l[b],l[c] = l[a],l[b],l[c]
        return l
    if l[b] == l[c]:
        l[a],l[b],l[c] = l[b],l[a],l[c]
        return l
    ### IF WE GOT THREE DISTINCT ITEMS
    if l[a] > l[b] and l[b] > l[c]:
        amax,amid,amin = a,b,c
    elif l[a] > l[c] and l[c] > l[b]:
        amax,amid,amin = a,c,b
    elif l[b] > l[c] and l[c] > l[a]:
        amax,amid,amin = b,c,a
    elif l[b] > l[a] and l[a] > l[c]:
        amax,amid,amin = b,a,c
    elif l[c] > l[a] and l[a] > l[b]:
        amax,amid,amin = c,a,b
    elif l[c] > l[b] and l[b] > l[a]:
        amax,amid,amin = c,b,a
    else:
        print "Error: WTF this should not happen"
        return None
    # Now just reorder so the mid is on an end
    l[a],l[b],l[c] = l[amid],l[amax],l[amin]
    return l

def parseInputFile(afile):
    """
    Parse an input file for lists
    Return a list of lists
    See Problem A specs for input format.
    """
    lists = [] # list of lists to return

    numLists = int(afile.readline()) # lists to read in
    print 'Got numLists:', numLists
    for i in range(numLists):
        afile.readline() # empty line
        afile.readline() # empty line
        alist = [int(c) for c in afile.readline().split()]
        lists.append( alist ) #append a tuple
    # return a list of lists
    return lists

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
