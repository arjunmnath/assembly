global _start

section .bss
	buffer resb 16

section .text
_start:
	
	;sys_read(stdin)
	mov rax, 0
	mov rdi, 0
	mov rsi, buffer
	mov rdx, 16

	syscall
	;sys_write(stdout)
	mov rax, 1
	mov rdi, 1
	mov rsi, buffer
	mov rdx, 16
	syscall
	;sys_exit
	mov rax, 60
	mov rdi, 69
	syscall
section .data
inp db 0
