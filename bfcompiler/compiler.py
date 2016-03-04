
# ==============================================================================
# | BRAINFUCK COMPILER
# |  by K. Le Run
# ==============================================================================

import re
import argparse
import os

comments     = re.compile( "[^\[\]+-><]+(.*)" )
counters     = re.compile( "([+-]+)(.*)" )
ptrmovements = re.compile( "([<>]+)(.*)" )

# Compiles a brainfuck program to assembly code
def compile( program, depth=0 ):
    out = ""
    loops = 0
    while len( program ) > 0:
        countersmatch = counters.match( program )
        if( countersmatch ):
            substring = countersmatch.group(1)
            value     = 2 * substring.count( '+' ) - len( substring )
            out      += "    add byte [eax], byte %d\n" % ( value % 256 )
            program   = countersmatch.group(2)
        ptrmovementsmatch = ptrmovements.match( program )
        if( ptrmovementsmatch ):
            substring = ptrmovementsmatch.group(1)
            value     = 2 * substring.count( '>' ) - len( substring )
            out      += "    add eax, %d\n" % value
            program   = ptrmovementsmatch.group(2)
        commentsmatch = comments.match( program )
        if( commentsmatch ):
            program = commentsmatch.group(1)
        if( program != "" and program[0] == "]" ):
            return (out, program[1:])
        if( program != "" and program[0] == "[" ):
            startlabel = "loop_start_%d_%d" % ( depth, loops )
            endlabel   = "loop_ended_%d_%d" % ( depth, loops )
            out += "%s:\n" % startlabel
            out += "    mov ebx, [eax]\n"
            out += "    or ebx, ebx\n"
            out += "    jz %s\n" % endlabel
            newout, program = compile( program[1:], depth+1 )
            out += newout
            out += "    jmp %s\n" % startlabel
            out += "%s:\n" % endlabel
            loops += 1
    return out

parser = argparse.ArgumentParser()
parser.add_argument("input_file", help = "the brainfuck code to compile")
parser.add_argument("-o", "--output_file", help = "file in which to output assembly")
args = parser.parse_args()

if not args.output_file:
    root, ext = os.path.splitext( args.input_file )
    args.output_file = root + ".asm"

with open( args.input_file, "r" ) as in_file:
    program = in_file.read()

with open( args.output_file, "w" ) as out_file:
    out_file.write( compile( program) )


