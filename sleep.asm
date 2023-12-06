global _start


section .data
	time_specification_struct:
		tv_sec dd 5 ; seconds to sleep
		tv_nsec dd 0 ; nanoseconds to sleep
section .text
_start:
	;----------------------------------------------------
	; sys_nanosleep
	;----------------------------------------------------
	; rax -> 35
	; rdi -> timespec *rqtp ( pointer to timespec struct 
	;	that specifies the time interval for 
	;	which you want to suspend the thread.)
	; rsi -> timespec *rmtp (NULL, or a pointer to a timespec 
	;	structure where the function can store the amount
	;	 of time remaining in the interval (the requested 
	;	time minus the time actually slept).)
	;-----------------------------------------------------
	mov rax, 35
	mov rdi, time_specification_struct 
	xor rsi, rsi
	syscall
	jmp sys_exit
sys_exit:
	mov rax, 60
	xor rdi, rdi
	syscall
