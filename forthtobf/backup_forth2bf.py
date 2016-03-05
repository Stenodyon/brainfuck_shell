
# ==============================================================================
# | FORTH TO BRAINFUCK COMPILER
# |  by K. Le Run
# ==============================================================================

import argparse
import re

class RedefinitionError(Exception):
    def __init__(self,name):
        Exception.__init__(self,"Word already defined : %s" % name)

class UnboundValueError(Exception):
    def __init__(self,name):
        Exception.__init__(self,"Unbound word : %s" % name)

new_word = re.compile( ":\s*(\w*)([^;]*);(.*)" )
code     = re.compile( "([^:]*)(:.*|$)" )
comments = re.compile( "[(][^)]*[)]" )

instruction = {
    "dup": "<[->+>+<<]>>[-<<+>>]",
    "swap": "<<[->>+<<]>[-<+>]>[-<+>]",
    "drop": "<[-]",
    "+": "<[-<+>]",
    "-": "<[-<->]",
    ".": "<.[-]",
    "getc": ",>",
    "wnz": "<[>",
    "loop": "<]>"
}

def compileint( integer ):
    out = "[-]"
    for i in range( integer ):
        out += "+"
    return out + ">\n"

lit_int = re.compile( "[0-9]+" )
lit_str = re.compile( "[\"'](.*)[\"']" )

def compileword( word ):
    lit_intmatch = lit_int.match( word )
    if lit_intmatch:
        return compileint( int( word ) )
    lit_strmatch = lit_str.match( word )
    if lit_strmatch:
        out = ""
        for c in lit_strmatch.group(1):
            out += compileint( ord(c) )
        return out
    else:
        if not word in instruction:
            raise UnboundValueError( word ) 
        return instruction[word] + "\n"

def compile( program ):
    out = ""
    while( len( program ) > 0 ):
        new_wordmatch = new_word.match( program )
        if new_wordmatch:
            word = new_wordmatch.group(1)
            if word in instruction:
                raise RedefinitionError(word)
            instruction[word] = compile( new_wordmatch.group(2) )
            program = new_wordmatch.group(3)
        codematch = code.match( program )
        if codematch:
            words         = filter( None, codematch.group(1).split( " " ) )
            compiledwords = map( compileword, words )
            out          += "".join( compiledwords )
            program       = codematch.group(2)
    return out

parser = argparse.ArgumentParser()
parser.add_argument( "input_file", help = "the forth code to compile" )
parser.add_argument( "-o", "--output_file", help = "file in which to output brainfuck" )
args = parser.parse_args()

if not args.output_file:
    root, ext = os.path.splitext( args.input_file )
    ags.output_file = root + ".bf"

with open( args.input_file, "r" ) as in_file:
    program = comments.sub( "", in_file.read().replace( "\n", " " ) )

with open( args.output_file, "w" ) as out_file:
    out_file.write( compile( program ) )
