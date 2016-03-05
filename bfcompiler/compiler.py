
# ==============================================================================
# | BRAINFUCK COMPILER
# |  by K. Le Run
# ==============================================================================

import re
import argparse
import os

comments     = re.compile( "[^\[\]+-><.,]" )
counters     = re.compile( "([+-]+)(.*)" )
ptrmovements = re.compile( "([<>]+)(.*)" )
clear        = re.compile( "[+-]*(\[+\]+|\[-\])+([+-]*)(.*)" )

# Compiles a brainfuck program to assembly code
def compile( program, depth=0 ):
    out = ""
    loops = 0
    while len( program ) > 0:
        clearmatch = clear.match( program )
        if clearmatch:
            substring = clearmatch.group(2)
            value     = 2 * substring.count( '+' ) - len( substring )
            out    += "    mov byte [ds:bx], byte %d\n" % ( value % 256 )
            program = clearmatch.group(3)
            continue
        countersmatch = counters.match( program )
        if countersmatch:
            substring = countersmatch.group(1)
            value     = 2 * substring.count( '+' ) - len( substring )
            if value != 0:
                out      += "    add byte [ds:bx], byte %d\n" % ( value % 256 )
            program   = countersmatch.group(2)
            continue
        ptrmovementsmatch = ptrmovements.match( program )
        if ptrmovementsmatch:
            substring = ptrmovementsmatch.group(1)
            value     = 2 * substring.count( '>' ) - len( substring )
            if value != 0:
                out      += "    add bx, %d\n" % value
            program   = ptrmovementsmatch.group(2)
            continue
        if program != "" and program[0] == "]":
            return (out, program[1:])
        if program != "" and program[0] == "[":
            startlabel = "loop_start_%d_%d" % ( depth, loops )
            endlabel   = "loop_ended_%d_%d" % ( depth, loops )
            out += "%s:\n" % startlabel
            out += "    mov al, byte [ds:bx]\n"
            out += "    or al, al\n"
            out += "    jz %s\n" % endlabel
            newout, program = compile( program[1:], depth+1 )
            out += newout
            out += "    jmp %s\n" % startlabel
            out += "%s:\n" % endlabel
            loops += 1
        if program != "" and program[0] == ".":
            out    += "    mov al, byte [ds:bx]\n"
            out    += "    call putc\n"
            program = program[1:]
        if program != "" and program[0] == ",":
            out    += "    call getc\n"
            program = program[1:]
    return out

parser = argparse.ArgumentParser()
parser.add_argument("input_file", help = "the brainfuck code to compile")
parser.add_argument("-o", "--output_file", help = "file in which to output assembly")
args = parser.parse_args()

if not args.output_file:
    root, ext = os.path.splitext( args.input_file )
    args.output_file = root + ".asm"

with open( args.input_file, "r" ) as in_file:
    program = comments.sub( "", in_file.read() )

with open( args.output_file, "w" ) as out_file:
    out_file.write( compile( program) )


