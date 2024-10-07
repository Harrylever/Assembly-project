section .data
    array_size EQU 5
    myArray dd 1, 2, 3, 4, 5
    myText db "Hello", 0

section .text
global  _start

_start:
    mov ecx, array_size

loop_to_print:
    mov eax, 4
    mov ebx, 1
    mov ecx, myText
    mov edx, array_size
    int 0x80

    ; exit
    mov eax, 1
    mov ebx, 0
    int 0x80