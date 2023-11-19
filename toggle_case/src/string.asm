;; String Manipulation ;; ~ eylon

extern in_range

global toggle_case

section .text
;; Toggle string's upper/lower case :: "Joe is FAT!" --> "jOE IS fat!"
;; >> [1] null terminated char buffer pointer
toggle_case:
    ; prologue
    push rbp
    mov rbp, rsp

    mov rsi, [rbp+16]       ; store the string address in rsi
    mov rdx, 0              ; set rdx as 0 to keep track of string's index

    .str_loop:              ; LOOP START
        mov bl, [rsi+rdx]   ; rax stores the current iterated character

        test bl, bl         ; test for null terminator i.e. end of string
        jz .str_loop_end    ; end the loop if found the null terminator

        mov rax, 'a'            ; set function parameter
        mov rcx, 'z'            ; set function parameter

        ; check if the character is an abc letter
        push rbx                ; @tested character
        push rax                ; @starting range
        push rcx                ; @end range
        call in_range           ; check if the character is in [a-z]
        
        test rax, rax           ; test return value, check if is an abc character
        jnz .toggle             ; toggle the case if is in range (abc character)

        mov rax, 'A'            ; set function parameter
        mov rcx, 'Z'            ; set function parameter

        ; check if the character is an ABC letter
        push rbx                ; @tested character
        push rax                ; @starting range
        push rcx                ; @end range
        call in_range           ; check if the character is in [A-Z]
                
        test rax, rax           ; test return value, check if is an ABC character
        jz .continue            ; continue the loop without changing the character if is not in range (not ABC character)

        ; toggle the case by flipping the 6st bit of the character
        .toggle:
        xor [rsi+rdx], byte 0b00100000

        .continue:              ; continue to the next character
        inc rdx                 ; increament rdx
        jmp .str_loop           ; loop

    .str_loop_end:          ; LOOP END


    ; epilogue
    mov rsp, rbp
    pop rbp
    ret