global _start

section .text
_start:
	mov r10, 0
	jmp loop
loop:
	cmp r10, 10
	jl printf
	jge sys_exit	

printf:
	inc r10
	mov rax, 1
	mov rdi, 1
	mov rsi, msg
	mov rdx, len
	syscall
	jmp loop

sys_exit:
	mov rax, 60
	mov rdi, 69
	syscall
	

section .data:
msg db "hello world", 10
len equ $ - msg
