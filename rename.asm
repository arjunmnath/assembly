
global _start

section .data
	old db "/home/arjun/Desktop/assembly/calc.s", 0
	new db "/home/arjun/Desktop/assembly/calculator.s", 0

section .text
	_start:
		mov rax, 82
		mov rdi, old
		mov rsi, new
		syscall

		mov rax, 60
		xor rdi, rdi
		syscall
