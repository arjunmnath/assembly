
global _start
section .text

_start:
	mov r10, 12
	mov r11, 14
	cmp r10, r11
	mov rsi, ms
	mov rdx, lens
	je _print
	mov rsi, mf
	mov rdx, lenf
	jne _print
_print:
	endbr64
	mov rax, 1
	mov rdi, 1
	syscall
	call sys_exit
sys_exit:
	mov rax, 60
	mov rdi, 69
	syscall	
section .data
	ms db "Equal", 10
	lens equ $ - ms
	mf db "Not equal", 10
	lenf equ $ - mf
