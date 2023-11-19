;; IO Manager ;; ~ eylon

%include "consts.asm"

global print
global get_input

section .text
;; Print a null terminated string
;; >> [1] string_pointer
print:
	; prologue
	push rbp
	mov rbp, rsp

	; get the string length
	mov rsi, [rbp+16]	; get the string passed on the stack
	mov rdx, 0			; store string's length

	.strlen_loop:		
		mov al, [rsi+rdx]
		test al, al 		; check for the null terminator
		jz .strlen_loop_end ; end the loop if found the null terminator
		
		inc rdx		 	 	; increament rdx (string's length)
		jmp .strlen_loop 	; loop
	.strlen_loop_end:

	; write to screen
	mov rax, 1		; sys_write(
	mov rdi, 1		; 	fd=stdout,
	mov rsi, rsi	; 	string,
	mov rdx, rdx	; 	length
	syscall			; );
		

	; epilogue
	mov rsp, rbp
	pop rbp
	ret

;; Get user input
;; >> [1] char buffer pointer to put the input in
;; << input length's
get_input:
	; prologue
	push rbp
	mov rbp, rsp

	; read input
	.get:
	mov rax, 0				; sys_read(
	mov rdi, 0				; fd=stdin
	mov rsi, [rbp+16]		; input buffer 
	mov rdx, INPUT_LENGTH	; length
	syscall				; );

	mov rax, rax 	; return input's length

	; epilogue
	mov rsp, rbp
	pop rbp
	ret