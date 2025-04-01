global _start

section .data
	buffer_out db 255 dup(0)
	path db "/home/arjun", 0
section .text
	_start:
		call chdir
		mov rdi, buffer_out
		call getcwd
		mov rsi, buffer_out
		mov rdx, 255
		call printf
		jmp sys_exit	

chdir:
	;------------------------
	; sys_chdir
	;------------------------
	; rax -> 80
	; rdi -> const char* buffer
	;------------------------
	mov rax, 80
	mov rdi, path
	syscall
	ret

getcwd:
	mov rax, 79
	mov rsi, 255
	syscall
	ret	

printf:
	mov rax, 1
	mov rdi, 1
	syscall
	ret		
sys_exit:
	mov rax, 60
	xor rdi, rdi
	syscall
