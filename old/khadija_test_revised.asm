section .data
    prompt db "Enter an integer: ", 0
    result_msg db "The sum is: %d", 0
    buffer db 12 dup(0)
    intArray dd 5 dup(0)
    sum dd 0

section .code
main PROC
    mov dword ptr [sum], 0

    mov ecx, 5
    lea edi, intArray

input_loop:
    invoke WriteString, addr prompt

    invoke ReadString, addr buffer, sizeof buffer

    invoke atodw, addr buffer
    mov [edi], eax
    add [sum], eax

    add edi, 4

    loop input_loop

    invoke wsprintf, addr buffer, addr result_msg, [sum]
    invoke WriteString, addr buffer

    invoke ExitProcess, 0

main ENDP
END main