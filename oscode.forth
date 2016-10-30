
( FORTH BASE FUNCTIONS )
: dup  {<[->+>+<<]>>[-<<+>>]} ;
: swap {<<[->>+<<]>[-<+>]>[-<+>]} ;
: drop {<[-]} ;
: +    {<[-<+>]} ;
: -    {<[-<->]} ;
: /    {<<[>[->+>+<<]>[-<<-[>]>>>[<[-<->]<[>]>>[[-]>>+<]>-<]<<]>>>+<<[-<<+>>]<<<] 
>>>>>[-<<<<<+>>>>>]<<<<<>[-]} ;
: %    {<<[>[->+>+<<]>[-<<-[>]>>>[<[-<->]<[>]>>[[-]>>+<]>-<]<<]>>>+<<[-<<+>>]<<<] 
>>>>>[-<<<<<+>>>>>]<<<<<[-]>[-<+>]} ;
: .    {<.[-]} ;
: over {<<[->>+>+<<<]>>>[-<<<+>>>]} ;

( BRAINFUCK FUNCTIONS )
: getc {,>} ;

( OTHER FUNCTIONS )
: newline 10 . 13 . ;

: divmod {<<[>[->+>+<<]>[-<<-[>]>>>[<[-<->]<[>]>>[[-]>>+<]>-<]<<]>>>+<<[-<<+>>]<<<] 
>>>>>[-<<<<<+>>>>>]<<<} ;

: print_int {<>>++++++++++<<[->+>-[>+>>]>[+[-<+>]>+>>]<<<<<<]>>[-]>>>++++++++++<[->-[>+>>]>[+[-
<+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>]<.<<+>+>[-]]<[<[->-<]++++++[->++++++++
<]>.[-]]<<++++++[-<++++++++>]<.[-]<<[-<+>]<[-]} ;

( LOGIC )
: not {<[>+<[-]]+>[<->-]} ;
: and {<<[>>>+<<<-]>>>[[-]<<[>>+<+<-]>[<+>-]>[<<<+>>>[-]]]} ; (UNTESTED)
: or not swap not and ; (UNTESTED)

( BRANCHING )
: if {<[[-]} ;
: fi {]} ;

: ife  dup not swap if drop ;
: else 0 fi if ;
: efi  fi ;

: wnz {<[>} ; ( while not zero )
: loop {<]} ;

( OS STUFF )

: print_string {<[<]+>>} wnz . {>>} loop {-[+<-]} ;

: repeat over {<<<[-]>[-[>]} dup {<[<]>]>[>]} ;

( !!!! TODO strcpy and strcmp )

: greet 0 "Hello, Stenodyon" 10 13
"=" 80 repeat
print_string print_string ;

: = - not ;

: get_string 1
wnz getc 
    dup 8 = ife ( 8 = backspace )
        drop dup 1 - if drop 8 . " " . 8 . fi
    else
        dup 13 = ife ( 13 = return )
            drop newline 0
        else
	    dup .
	efi
    efi
loop {-[+<-]>[>]} 10 13 ;

: main greet 1 wnz 0 "stenodyon$ " print_string get_string print_string loop ;
main