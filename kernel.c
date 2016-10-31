#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#define VIDEO 0xB8000

void putc(char c)
{
    char * video = (char*)VIDEO;
    video[0] = c;
    video[1] = 0x07;
}

void kernel_main(void)
{
    putc('>');
}
