
from getopt import gnu_getopt
import sys

options, remainder = gnu_getopt( sys.argv[1:], "o:" )

outfile = "a.out"
infile = "a.in"

for option, value in options:
    if option == "-o":
        outfile = value

if len(remainder):
    infile = remainder[0]

with open( infile, "rb" ) as inf:
    with open( outfile, "rb+" ) as outf:
        while True:
            byte = inf.read(1)
            if not byte:
                break
            #outf.write( byte )

print( "Done" )
