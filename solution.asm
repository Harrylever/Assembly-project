section .bss
    input RESB 10 ; reserve 10 bytes for input

section .data
    prompt db 0xA, "Enter an integer: "
    prompt_len equ $ - prompt ; length of the prompt

    result_msg db 0xA, "The sum is: "
    result_msg_len equ $ - result_msg

    buffer db 12 dup(0)     ; buffer for input
    intArray db 5 dup(0)    ; array to store integers
    arraySize db 0
    sum dd 0

section .text

global _start
global _end

_start:
    mov esi, 5              ; loop 5 times

loop_prompt_handler:
    dec esi                 ; decrement loop counter
    ; print the prompt to enter input
    mov eax, 4              ; sys_write
    mov ebx, 1              ; file descriptor 1 (stdout)
    mov ecx, prompt         ; message to print
    mov edx, prompt_len     ; number of bytes to read
    int 0x80

    ; read the input
    mov eax, 3              ; sys_read
    mov ebx, 0              ; file descriptor 0 (stdin)
    mov ecx, input          ; message to read
    mov edx, 10             ; number of bytes to read
    int 0x80

    ; convert ASCII input to integer
    call str_to_int

    ; append the integer to the array
    mov edi, [arraySize]
    mov [intArray + edi], al

    ; increment array size
    inc byte [arraySize]    ; increment array size

    ; add the input number to the sum
    add dword [sum], eax

    ; print the sum
    mov ecx, [sum]
    mov ecx, buffer
    call int_to_string

    ; print the sum at the end of every loop iteration
    mov eax, 4              ; sys_write
    mov ebx, 1              ; file descriptor 1 (stdout)
    mov ecx, buffer         ; buffer containing the sum as a string
    mov edx, 12             ; length of the buffer
    int 0x80

    cmp esi, 0
    jz _end
    jmp loop_prompt_handler ; loop_prompt_handler label if ecx is not zero

_end:
    ; print the result
    mov eax, 4              ; sys_write
    mov ebx, 1              ; file descriptor 1 (stdout)
    mov ecx, result_msg     ; message to print
    mov edx, result_msg_len ; number of bytes to read
    int 0x80

    ; convert sum to string
    mov eax, [sum]
    mov ecx, buffer
    call int_to_string

    ; print the sum
    mov eax, 4              ; sys_write
    mov ebx, 1              ; file descriptor 1 (stdout)
    mov ecx, buffer         ; buffer containing the sum as a string
    mov edx, 12             ; length of the buffer
    int 0x80

    ; exit
    mov eax, 1              ; sys_exit
    xor ebx, ebx            ; exit code
    int 0x80

str_to_int:
    ; ecx: pointer to input string
    ; eax: result
    xor eax, eax            ; clear eax
    xor edx, edx            ; clear edx

    str_to_int_loop:
        movzx edx, byte [ecx]
        test dl, dl
        jz str_to_int_end
        sub dl, '0'
        imul eax, eax, 10
        add eax, edx
        inc ecx
        jmp str_to_int_loop
    
    str_to_int_end:
        ret

int_to_string:
    ; eax contains the string to convert
    ; ecx points to the buffer to store the string
    mov edi, ecx
    add edi, 11
    mov byte [edi], 0
    dec edi

    .convert_loop:
        xor edx, edx
        mov ebx, 10
        div ebx
        add dl, '0'
        mov [edi], dl
        dec edi
        test eax, eax
        jnz .convert_loop

    inc edi
    mov ecx, edi
    ret