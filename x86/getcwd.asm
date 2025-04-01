global _start

section .data
	buffer db 255 dup(0) ; buffer-> 255 bytes long each byte initalized with 0
	
section .text
	_start:
		call getcwd
		call printf
		jmp sys_exit	
getcwd:
	;---------------------------
	;sys_getcwd
	;---------------------------
	; rax -> 79
	; rdi -> char *buff
	; rsi -> unsigned long size
	;---------------------------
	mov rax, 79
	mov rdi, buffer
	mov rsi, 255
	syscall
	ret	

printf:
	mov rax, 1
	mov rdi, 1
	mov rsi, buffer
	mov rdx, 255
	syscall
		
sys_exit:
	mov rax, 60
	xor rdi, rdi
	syscall
