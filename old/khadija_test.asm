include C:\Irvine\Irvine32.inc
includelib C:\Irvine\Irvine32.lib
includelib C:\Irvine\Kernel32.Lib
includelib C:\Irvine\User32.Lib

.data
    prompt db "Enter an integer: ", 0
    result_msg db "The sum is: %d", 0
    buffer db 12 dup(0) ; buffer for input
    intArray dd 5 dup(0)
    sum dd 0

.code
main PROC
    ; Initialize sum to 0
    mov dword ptr [sum], 0

    ; Loop to get 5 integers
    mov ecx, 5 ; loop counter
    lea edi, intArray ; pointer to the array

input_loop:
    ; Print the prompt
    invoke WriteString, addr prompt

    ; Read an integer
    invoke ReadString, addr buffer, sizeof buffer

    ; Convert ASCII to integer
    invoke atodw, addr buffer
    mov [edi], eax ; store integer in array
    add [sum], eax ; add to sum

    ; Move to the next element in the array
    add edi, 4

    loop input_loop

    ; Print the result message with the sum
    invoke wsprintf, addr buffer, addr result_msg, [sum]
    invoke WriteString, addr buffer

    ; Exit the program
    invoke ExitProcess, 0

main ENDP
END main