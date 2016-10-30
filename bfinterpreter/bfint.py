#! /usr/bin/python3

from getch import getch
import sys

def output(string):
    print(string, end="")

def input():
    return ord(getch())

class Interpreter:

    def __init__(self, program, debug=False):
        self.mem = [0 for i in range(3000)]
        self.memptr = 0

        self.cellsize = 256
        self.ic = 0

        self.instruction = {
            "+": self._plus,
            "-": self._minus,
            "<": self._left,
            ">": self._right,
            "[": self._ob,
            "]": self._cb,
            ".": self._dot,
            ",": self._comma,
        }

        self.prog = ""
        for c in program:
            if c in self.instruction:
                self.prog += c

        self.debug = debug
        if self.debug:
            print("*** Program Start ***", file=sys.stderr)

    def _plus(self):
        self.mem[self.memptr] = ( self.mem[self.memptr] + 1 ) % self.cellsize

    def _minus(self):
        self.mem[self.memptr] = ( self.mem[self.memptr] - 1 ) % self.cellsize

    def _right(self):
        self.memptr = ( self.memptr + 1 ) % len( self.mem )

    def _left(self):
        self.memptr = ( self.memptr - 1 ) % len( self.mem )

    def _ob(self):
        if self.mem[self.memptr] == 0:
            bracketcounter = 1
            while bracketcounter > 0:
                self.ic += 1
                char = self.prog[self.ic]
                if char == "[":
                    bracketcounter += 1
                elif char == "]":
                    bracketcounter -= 1

    def _cb(self):
        if self.mem[self.memptr] != 0:
            bracketcounter = 1
            while bracketcounter > 0:
                self.ic -= 1
                char = self.prog[self.ic]
                if char == "]":
                    bracketcounter += 1
                elif char == "[":
                    bracketcounter -= 1

    def _dot(self):
        i = self.mem[self.memptr]
        c = chr(i)
        if self.debug:
            print("Outputing value %i (%c)" % (i,c), file=sys.stderr)
        output(c)

    def _comma(self):
        c = input()
        if self.debug:
            print("Pressed value %i (%c)" % (c, c), file=sys.stderr)
        self.mem[self.memptr] = c

    def memdump(self):
        bot = self.memptr - 15
        if bot < 0:
            bot = 0
        top = self.memptr + 15
        if bot >= len(self.mem):
            bot = len(self.mem) - 1
        for value in self.mem[bot:top]:
            print("{:02x} ".format(value), end="", file=sys.stderr)
        try:
            print("| %i | %s " % (self.ic, self.prog[self.ic]), end="", file=sys.stderr)
        except:
            print("|%i" % self.ic, end="", file=sys.stderr)
        length = 30
        if bot == 0:
            length = 3 * self.memptr
        print("\n" + " " * length + "|", end="", file=sys.stderr)
        """
        for i in range( len( self.mem ) ):
            char = " "
            if i == self.memptr:
                char = "i"
            print(char + " ", end="", file=sys.stderr)
        """
        print("\n", end="", file=sys.stderr)

    def run(self,max_iterations=None):
        if self.debug:
            def step():
                self.memdump()
                self.instruction[ self.prog[ self.ic ] ]()
                self.ic += 1
        else:
            def step():
                self.instruction[ self.prog[ self.ic ] ]()
                self.ic += 1
        program_length    = len(self.prog)
        iteration_counter = 0
        while self.ic < program_length and \
              ( max_iterations == None or iteration_counter < max_iterations ):
            step()
            if max_iterations != None:
                iteration_counter += 1
        if self.debug:
            self.memdump()

if __name__ == "__main__":
    from curses import wrapper, noecho
    def main(stdscr):
        global output, input
        noecho()
        def _output(string):
            for c in string:
                if ord(c) == 8:
                    (y, x) = stdscr.getyx()
                    stdscr.move(y, x-1)
                else:
                    stdscr.addch(c)
            stdscr.refresh()
        def _input():
            c = stdscr.getch()
            if c == 10:
                c = 13
            elif c == 263:
                c = 8
            return c
        output = _output
        input = _input
        stdscr.clear()
        with open( "prog.bf", "r" ) as f:
            rawprog = f.read()
        inter = Interpreter(rawprog, debug=True)
        inter.run()
        stdscr.addstr("\n\nProgram terminated\n")
        stdscr.getch();
    wrapper(main)
