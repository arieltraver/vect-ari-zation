global dotProduct
;SO when you are working with floating points, the return value goes in xmm0

section .data

section .text ;pointer to arrays in rsi and rdi, length stored in rdx, result stored in the address pointed to by rsi
dotProduct: 	push rbp
		mov rbp, rsp ;new stack frame
		vzeroall ;empty the ymme registers.

multiply:	vmovaps ymm3, [rdi] ;move 8 dwords into registers.
		vmovaps ymm1, [rsi] ;from the addresses stored in rsi and rdi
		vmulps ymm3, ymm1, ymm3 ;dot of this

horizadd:	vextractf128 xmm4, ymm3, 1
		haddps xmm3, xmm4
		haddps xmm3, xmm3
		movaps xmm4, xmm3
		vshufps xmm3, xmm4, 0x1
		haddps xmm3, xmm3
		addps xmm0, xmm3
		subps xmm4, xmm4

end:		pop rbp;
