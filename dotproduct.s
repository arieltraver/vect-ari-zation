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
		jge workChunk ;working on a non-full-sized chunk, ending
		cmp 128, rdx
		jge workPart
		cmp 0, rdx
		jg workBit
		pop rbp
		ret
workChunk:
		vmovaps ymm0, [rsi] ;move 256 unaligned bytes of first array
		vmovaps ymm1, [rdi] ;heap address stored in rsi and rdi
		vmulps ymm0, ymm1 ;dot of this section
		vmovaps ymm0, [rsi]
		add rdi, 256 ;next block
		add rdi, 256
		sub rdx, 256
		jmp =comp	

workPart: ;length > 128 but less than 256. use partial move and exit.

workBit: ;length > 0 but less than 128. use the xmme (lower halves) and exit

