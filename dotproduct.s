global dotProduct

section .data

section .text ;pointer to arrays in rsi and rdi, length stored in rdx, result stored in the address pointed to by rsi
dotProduct: 	push rbp
		mov rbp, rsp ;new stack frame
		mov r8, 8 ;for comparison
		vzeroall ;empty the ymme registers.
break0:
comp:
		cmp rdx, r8 ;rdx stores remaining len of array
		jge multiply ;if we have >=8 dwords left, jump
		;cmp 0, rdx ;remaining dwords that dont fully fill ymme.?
		;jg workPart ;deal with partially filled register
		pop rbp ;we are done here, close our stack frame.
		ret

multiply:	vmovaps ymm0, [rdi] ;move 8 dwords into registers.
		vmovaps ymm1, [rsi] ;from the addresses stored in rsi and rdi
		vmulps ymm0, ymm1, ymm0 ;dot of this

horizadd:	vextractf128 xmm4, ymm0, 1 ;get upper half into xmm4
		vzeroupper ;not using this
		phaddd xmm0, xmm4;
		phaddd xmm0, xmm0;
movepointers: 
		mov r9, rdx
		shl r9, 5 ;32 bits per dword equals 2^5.
		add rdi, r9 ;move the pointer along.
		add rsi, r9 ;move the other pointer along.
		sub rdx, 8 ;subtract from the remaining array length..
		jmp comp ;go see if we're done yet.

