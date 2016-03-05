
# ==============================================================================
# | FORTH TO BRAINFUCK COMPILER
# |  by K. Le Run
# ==============================================================================

import argparse
import re

tokens = (
    "INT_LIT",
    "STR_LIT",
    "BFC_LIT",
    "WORD"
)

literals = [ ':', ';' ]

t_INT_LIT = r'[0-9]+'

def t_STR_LIT(t):
    '("[^"]*"|\'[^\']*\')'
    t.value = t.value[1:-1]
    return t

def t_BFC_LIT(t):
    '[{][^}]*[}]'
    t.value = t.value[1:-1]
    return t

def t_WORD(t):
    r'[^0-9\s:;{}][^\s:;{}]*'
    return t

def t_error(t):
    print( "Illegal character '%s'\r" % t.value[0], end="" )
    t.lexer.skip(1)

import ply.lex as lex
lex.lex()

instruction = {}

def make_int( n ):
    return "[-]" + "+" * n + ">"

def p_program(p):
    'program : definitions WORD'
    p[0] = instruction[p[2]]

def p_definitions(p):
    'definitions : definitions definition'
    pass

def p_definitions_definition(p):
    'definitions : definition'
    pass

def p_definition(p):
    'definition : ":" WORD statement ";"'
    instruction[p[2]] = p[3]

def p_statement(p):
    'statement : statement element'
    p[0] = p[1] + p[2]

def p_statement_word(p):
    'statement : element'
    p[0] = p[1]

def p_element_word(p):
    'element : WORD'
    p[0] = instruction[p[1]]

def p_element_int(p):
    'element : INT_LIT'
    p[0] = make_int( int( p[1] ) )

def p_element_str(p):
    'element : STR_LIT'
    out = ""
    for c in p[1]:
        out += make_int( ord( c ) )
    p[0] = out

# Brainfuck literal { code }
def p_element_bfc(p):
    'element : BFC_LIT'
    p[0] = p[1]

def p_error(p):
    print( "Syntax error !" )
    print( p )

import ply.yacc as yacc
parserlexer = yacc.yacc()

def remove_comments( program ):
    out = ""
    parencount = 0
    for c in program:
        if c == "(":
            parencount += 1
        elif c == ")":
            parencount -= 1
        elif parencount == 0:
            out += c
    return out

parser = argparse.ArgumentParser()
parser.add_argument( "input_file", help = "the forth code to compile" )
parser.add_argument( "-o", "--output_file", help = "file in which to output brainfuck" )
args = parser.parse_args()

if not args.output_file:
    root, ext = os.path.splitext( args.input_file )
    ags.output_file = root + ".bf"

with open( args.input_file, "r" ) as in_file:
    program = remove_comments( in_file.read().replace( "\n", " " ) )

result = parserlexer.parse( program )

fprogram = ""
for i in range( len( result ) ):
    fprogram += result[i]
    if (i + 1) % 80 == 0:
        fprogram += "\n"

with open( args.output_file, "w" ) as out_file:
    out_file.write( fprogram )
