section .text
global  _start

_start:
    push 0x00646c72
    push 0x6f77206f
    push 0x6c6c6568

    mov  ecx, esp
    mov  edx, 11
    mov  ebx, 1
    mov  eax, 4
    int  0x80

    mov  eax, 1
    xor  ebx, ebx
    int  0x80