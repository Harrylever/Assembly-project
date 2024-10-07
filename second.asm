section .data
    char DB 'A'
    list DB 1,2,3,4,5,0
    string1 DB "ABC",0
    string2 DB "CDE",0

section .text

global _start
_start:
    MOV bl,[list]
    MOV eax,1
    INT 80h