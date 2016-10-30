
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

: = - not ;

( OS STUFF )

: print_string {<[<]+>>} wnz . {>>} loop {-[+<-]} ;

: repeat1 over {<<<[-]>--[[>]} dup {<[<]>-]>[-<+<+>>]<<[->>+<<]>[>]} ;
: repeat2
dup 0 = ife
    drop drop
else
    dup 1 = ife
        drop 0 swap
    else
        repeat1
    efi
efi ;
: repeat
over 0 = ife
    swap drop 1 swap repeat2 {<[<]>[->]}
else
    repeat2
efi ;

( !!!! TODO strcmp )

: strcpy
{< [[->>+[>]>+<<[<]<] >>[>]>[>]< [[->+<]<] <[<]<<]}
{>>>[[-<<+>>]>]>>[[-<<<+>>>]>]<<<} ;

: strdrop {<[[-]<]} ;

(str str -- char)
(Puts the last char of the 2nd string over the top of the stack)
: str2lastover
{<[<]< [->[>]>[>]>+<<[<]<]} (>[>]>[>]>>} Cuts it)
{>> [[-<+>]>]>[-<<+>>]<} ;

: strcmp
1 wnz drop
    dup not ife (if first string empty)
        str2lastover not ife (if second string empty)
            strdrop 1 0
        else
            strdrop strdrop 0 0
        efi
    else
        str2lastover dup not ife (if second string empty)
            drop strdrop 0 0
        else
            = ife
                1
            else
                strdrop strdrop 0 0
            efi
        efi
    efi
loop ;

: greet 0 "Hello, Stenodyon" 10 13
"=" 80 repeat 10 13
print_string print_string ;

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
loop {-[+<-]>[>]} ;

: main
greet
1 wnz
    0 "stenodyon$ " print_string
    get_string strcpy 0 "exit" strcmp ife
        strdrop drop 0
    else
        strcpy 0 "ls" strcmp ife
            strdrop 0 "Not implemented" 10 13 print_string
        else
            ": command not found" 10 13 print_string
        efi
    efi
loop ;

main
