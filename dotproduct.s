global _dotProduct

section .data
	arr0 dw 1.1, 2.2, 3.3, 4.4
	arr1 dw 2.0, 2.0, 2.0, 2.0
	zeros dw 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
section .text ;pointer to arrays in rsi and rdi, length stored in rdx, result stored in the address pointed to by rsi
_dotProduct: 	pop rbp
		mov rbp, rsp ;new stack frame
		vmovaps ymm0, zeros
		vmovaps ymm1, zeros ;zero out these registers

comp:
		
		cmp 256, rdx ;rdx stores remaining len of array
		jle workPart ;working on a non-full-sized chunk, ending
		sub rdx, 256
workChunk:
		vmovaps ymm0, [rsi] ;move 256 unaligned bytes of first array
		vmovaps ymm1, [rdi] ;heap address stored in rsi and rdi
		vmulps ymm0, ymm1 ;dot of this section
		vmovaps ymm0, [rsi]
		add rdi, 256 ;next block
		add rdi, 256
		jmp =comp
		
		movups [arr0], xmm0 ;store result in first array
break2:
exit:		mov rax, 60
		mov rdi, 0
		syscall 
		


