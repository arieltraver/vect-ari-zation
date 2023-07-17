;just to make sure stuff can actually compile
;running this on a x86 ubuntu VM

global _start

section .text

_start:
	mov rax, 1 ;write syscall id
	mov rdi, 1 ;standard ou
	mov rsi, msg
	mov rdx, len
	syscall

	mov rax, 60 ;exit syscall id
	mov rdi, 0 ;exit status 0
	syscall

section .rodata
	msg: db "Hello world", 10 ;10 is newline
	len: equ $ - msg ;I always wonder if this is getting instructions too
	 
