global dotProduct
;SO when you are working with floating points, the return value goes in xmm0

section .data

section .text ;pointer to arrays in rsi and rdi, length stored in rdx, result stored in the address pointed to by rsi
dotProduct: 	push rbp
		mov rbp, rsp ;new stack frame
		mov r8, 8 ;for comparison
		vzeroall ;empty the ymme registers.
comp:
		cmp r8, rdx ;rdx stores remaining len of array
test1:		jle multiply ;if we have >=8 dwords left, jump
		;cmp 0, rdx ;remaining dwords that dont fully fill ymme.?
		;jg workPart ;deal with partially filled register
		pop rbp ;we are done here, close our stack frame.
		jmp exit;

multiply:	vmovaps ymm3, [rdi] ;move 8 dwords into registers.
break0:		vmovaps ymm1, [rsi] ;from the addresses stored in rsi and rdi
		vmulps ymm3, ymm1, ymm3 ;dot of this

horizadd:	vextractf128 xmm4, ymm3, 1
		haddps xmm3, xmm4
		haddps xmm3, xmm3
		movaps xmm4, xmm3
		vshufps xmm3, xmm4, 0x1
		haddps xmm3, xmm3
test2:		addps xmm0, xmm3
		vmovaps xmm4, xmm7 ;zero
movepointers: 
		sub rdx, 8 ;subtract from the remaining array length.
		add rdi, 32 ;move the pointer along
		add rsi, 32 ;move the other pointer along
test0:		jmp comp ;go see if we're done yet.
exit:
