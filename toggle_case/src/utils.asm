;; Utils ;; ~ eylon

global in_range

section .text
;; check if a number is in a ranger
;; >> [1] number to be checked
;; >> [2] range low
;; >> [3] range high
;; << boolean <0>=not-in-range <1>=in-range
in_range:
    ; prologue
    push rbp
    mov rbp, rsp
    push rbx
    push rcx
    push rdx

    mov rax, 0              ; set return value as false (not-in-range) by default
    mov rbx, [rbp+8*4]       ; rbx = number to be checked
    mov rcx, [rbp+8*3]       ; rcx = range low
    mov rdx, [rbp+8*2]       ; rdx = range high

    ; [rbx] number < [rcx] low-range --> return false
    cmp rbx, rcx
    jb .return

    ; [rbx] number > [rdx] high-range --> return false
    cmp rbx, rdx
    ja .return

    ; else, return true
    mov rax, 1

    ; epilogue
    .return:
    pop rdx
    pop rcx
    pop rbx
    mov rsp, rbp
    pop rbp
    ret