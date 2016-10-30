#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#define MEMSIZE 3000

uint8_t memory[MEMSIZE];
uint8_t * mem_ptr = memory;

void find_closing(char ** pc)
{
    (*pc)++;
    unsigned int counter = 1;
    while(counter > 0)
    {
        if(**pc == '[')
            counter++;
        if(**pc == ']')
            counter--;
        (*pc)++;
    }
}

void find_opening(char ** pc)
{
    (*pc)--;
    unsigned int counter = 1;
    while(counter > 0)
    {
        if(**pc == '[')
            counter--;
        if(**pc == ']')
            counter++;
        (*pc)--;
    }
}

void run(char * input, char * program)
{
    char * pc = program;
    printf("%s\n", program);
    while(*pc)
    {
        //printf("%lu | %c | %i\n", pc - program, *pc, *mem_ptr);
        switch(*pc)
        {
            case '+':
                (*mem_ptr)++;
                break;
            case '-':
                (*mem_ptr)--;
                break;
            case '>':
                mem_ptr++;
                if(mem_ptr - memory >= MEMSIZE)
                    mem_ptr = memory;
                break;
            case '<':
                mem_ptr--;
                if(mem_ptr < memory)
                    mem_ptr = memory + MEMSIZE - 1;
                break;
            case '[':
                if(!*mem_ptr)
                    find_closing(&pc);
                break;
            case ']':
                if(*mem_ptr)
                    find_opening(&pc);
                break;
            case '.':
                putchar(*mem_ptr);
                break;
            case ',':
                if(*input)
                    *mem_ptr = *(input++);

                else
                    *mem_ptr = 0;
        }
        pc++;
    }
}

int main(int argc, char * argv[])
{
run("", "--[----->+<]>---.++++++++++++.+.+++++++++.+[-->+<]>+++.++[-->+++<]>.++++++++++++.+.+++++++++.-[-->+++++<]>++.[--->++<]>-.-----------.");
    return 0;
}
