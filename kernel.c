#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#define VIDEO 0xB8000
#define V_W 80
#define V_H 25

void memcpy(void * dest, void * src, int32_t length)
{
    uint8_t * d = (uint8_t*)dest;
    uint8_t * s = (uint8_t*)src;
    for(uint32_t i = 0; i < length; i++)
        d[i] = s[i];
}

uint8_t cursor[2] = { 0, 0 };

void newline()
{
    void * src = (void*)(VIDEO + 2 * V_W);
    memcpy((void*)VIDEO, src, 2 * V_W * (V_H - 1));
}

void move(uint8_t x, uint8_t y)
{
    if(x >= V_W)
    {
        y += x / V_W;
        x %= V_W;
    }
    if(y >= V_H)
    {
        for(; y > V_H; y--)
            newline();
        y = V_H;
    }
    cursor[0] = x;
    cursor[1] = y;
}

void putc(char c)
{
    char * video = (char*)VIDEO + 2 * (V_W * cursor[1] + cursor[0]);
    video[0] = c;
    video[1] = 0x07;
}

void kernel_main(void)
{
    putc('>');
    //move(1,1);
    //memcpy((void*)(VIDEO + 2 * V_W), (void*)VIDEO, 2 * V_W);
}
