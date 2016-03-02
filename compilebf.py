
inputfile = "program.bf"
outputfile = "bf.bin"

bfins = {
    "+": b'\x02',
    "-": b'\x04',
    "<": b'\x06',
    ">": b'\x08',
    "[": b'\x0a',
    "]": b'\x0c',
    ".": b'\x0e'
}

with open( inputfile, "rb" ) as inf:
    with open( outputfile, "wb" ) as outf:
        while True:
            byte = inf.read(1)
            if not byte:
                break
            if byte.decode() in bfins:
                outf.write( bfins[byte.decode()] )
        outf.write( bytes(1) )

print( "Done" )
