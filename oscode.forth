
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

: wnz {<[>} ;
: loop {<]} ;

( OS STUFF )

: print_string {<[<]+>>} wnz . {>>} loop {-[+<-]} ;

: greet 0 "Hello, Stenodyon" 10 13 print_string ;

: = - not ;

: get_string ">" . 1
wnz getc 
    dup 8 = ife
        drop dup 1 - if drop 8 . " " . 8 . fi
    else
        dup 13 = ife
            drop newline 0
        else
	    dup .
	efi
    efi
loop {-[+<-]>[>]} 10 13 ;

: main greet 1 wnz get_string print_string loop ;
main