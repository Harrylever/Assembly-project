section .bss
    num RESB 3

section .text

global _start

_start:
    MOV bl,1
    MOV [num],bl
    MOV [num+1],bl
    MOV [num+2],bl

    MOV eax,1
    INT 80h
