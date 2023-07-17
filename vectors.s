global _start

section .data
	arr0 dw 1.1, 2.2, 3.3, 4.4
	arr1 dw 5.5, 6.6, 7.7, 8.8
	zeros dw 0, 0, 0, 0
section .text
_start:
	movups xmm0, [arr0] ;move first array
	movups xmm1, [arr1]
	mulps xmm0, xmm1
	movups [arr0], xmm0 ;store result in first array

exit:	mov rax, 60
	mov rdi, 0
	syscall 
		


