global _start


section .bss
	buffer resb 8  
	tmp resb 8
section .text


_start:
	mov rdx, 8
	mov rsi, buffer
	call inp
	jmp times_table

; ------------------------------------------------------
; FUCNTION
; ------------------------------------------------------
; 1) parameter registers:-
; 	-- rsi -> mov input source address
; 2) internal registers used:-
;	-- rax -> stores parsed numeric value
;	-- ecx -> index of input source buffer
; 	-- edi -> stores ascii converted numeric value
; 3) purpose:- converts numeric str to int value
; 4) output:- final numeric value stored in rax register
; ------------------------------------------------------

str_to_int:
	xor ecx, ecx
	xor rax, rax
    movzx rdi, byte [rsi]
	sub edi, '0'
	imul rax, rax, 10
	add rax, rdi
	inc ecx
	movzx rdi, byte [rsi + rcx]
	cmp rdi, 10
	jne str_to_int + 0x9
	ret
; -----------------------------------------------------
; FUCNTION
; -----------------------------------------------------
; 1) parameter registers:-
; 	-- rsi -> mov output destination address
; 	-- rax -> mov value to be converted to str
; 2) internal registers used:-
;	-- rax -> dividend
; 	-- rcx -> divisor
; 	-- rdx -> reminder
; 3) Purpose:- converts int to str
; 4) output:- stores ascii representation of int at 
; 		at address in rsi	
; ------------------------------------------------------
int_to_str:
        mov ecx, 10
        add rsi, 8
        mov byte [rsi], 0
        mov rdx, 0 ; <- loop entry point
        div rcx
        add rdx, 0x30
        dec rsi
        cmp rax, 0
        mov [rsi], dl
        jne int_to_str + 0xc
        ret
 	
times_table:
	mov r9, 1
	mov rsi, buffer
	mov rdx, 8
	call str_to_int
	mov r10, rax	
	mov qword [buffer], 0
	call int_to_str
	jmp .loop_handle
	.loop_handle:
		cmp r9, 10
		jle .loop_block	
		jmp sys_exit
	.loop_block:
		; printf num 
		mov rsi, buffer
		mov rdx, 8
		call printf

		;printf x symbol
		mov rsi, x_symbol
		mov rdx, 3
		call printf
		; printf times num
		mov rax, r9 
		mov qword [tmp], 0
		mov rsi, tmp
		call int_to_str
		mov rsi, tmp
		mov rdx, 8
		call printf

		;printf equal symbol
		mov rsi, equal_symbol
		mov rdx, 3
		call printf

		; printf ans
		mov rax, r10
		imul rax, r9
		mov qword [tmp], 0
		mov rsi, tmp
		call int_to_str
		mov rdx, 8
		call printf

		;printf newline
		mov rsi, newline
		mov rdx, 1
		call printf
		inc r9
		jmp .loop_handle


; -----------------------------------------------------
; FUCNTION
; -----------------------------------------------------
; 1) parameter registers:-
;       -- rsi -> mov output destination address
;       -- rdx -> value of byte size of destination block
; 2) internal registers used:-
;       -- rax -> 0 (sys_read)
;       -- rdi -> 0 ( stdin )
; 3) Purpose:- takes input from terminal
; 4) output:- stores ascii representation of input at 
;               at address in rsi       
; ------------------------------------------------------
inp:
	xor rax, rax
	xor rdi, rdi
	syscall
	ret



; -----------------------------------------------------
; FUCNTION
; -----------------------------------------------------
; 1) parameter registers:-
;       -- rsi -> mov source address
;       -- rdx -> value of byte size of source block
; 2) internal registers used:-
;       -- rax -> 1 (sys_write)
;       -- rdi -> 1 ( stdout )
; 3) Purpose:- prints value in terminal
; 4) output:- Nil
; ------------------------------------------------------
printf:

	mov rax, 1
	mov rdi, 1
	syscall
	ret


; -----------------------------------------------------
; BLOCK
; -----------------------------------------------------
; 1) parameter registers:- Nil
; 2) internal registers used:-
;       -- rax -> 60 (sys_exit)
;       -- rdi -> 0 ( error_code )
; 3) Purpose:- terminates execution
; 4) output:- Nil
; ------------------------------------------------------
sys_exit:
	mov rax, 60
	xor rdi, rdi
	syscall

section .data
x_symbol db " x ", 0
equal_symbol db " = ", 0
newline db 10
symbol_length db 3
