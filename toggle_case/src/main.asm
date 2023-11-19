;; Main ;; ~ eylon

%include "consts.asm"

extern print
extern get_input
extern toggle_case

global _start

section .data
str_input: times INPUT_LENGTH db 0

section .text
_start:

	push str_input		; push input char buffer as a parmeter
	call get_input		; get user input
	call toggle_case	; toggle the string's case
	call print			; print the user's input
	
	mov rax, 60	; sys_exit(
	mov rdi, 0	; error_code
	syscall		; );
