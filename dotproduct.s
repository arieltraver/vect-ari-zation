global _dotProduct

section .data
	arr0 dw 1.1, 2.2, 3.3, 4.4
	arr1 dw 2.0, 2.0, 2.0, 2.0
section .text ;pointer to arrays in rsi and rdi, length stored in rdx, result stored in the address pointed to by rsi
_dotProduct: 	pop rbp
		mov rbp, rsp ;new stack frame
		vzeroall ;empty the ymme registers.
.comp:
		cmp 8, rdx ;rdx stores remaining len of array
		jge workChunk ;if we have >=8 dwords left, jump
		cmp 0, rdx ;remaining dwords that dont fully fill ymme.?
		jg workPart ;deal with partially filled register
		pop rbp ;we are done here, close our stack frame.
		ret
.workChunk:
		vmovaps ymm0, [rsi] ;move 8 dwords into registers.
		vmovaps ymm1, [rdi] ;from the addresses stored in rsi and rdi
		vmulps ymm0, ymm1 ;dot of this section
		vmovaps ymm0, [rsi] ;store product in the og mem location.
		mov r8, rdx
		shl r8, 5 ;32 bits per dword equals 2^5.
		add rdi, r8 ;move the pointer along.
		add rsi, r8 ;move the other pointer along.
		sub rdx, 8 ;subtract from the remaining array length..
		jmp =comp ;go see if we're done yet.

workPart:
		shr rdx, 5 ;get number of bits left (multiply by 32)
		vmovsd ymm2, 1
		;TODO: create a mask which selects remaining bits
		vmaskmovps ymm0, ymm2, [rsi]
		vmaskmovps ymm1, ymm2, [rdi]
		vmulps ymm0, ymm1
		vmaskmovps [rsi], ymm2, ymm0 

workBit: ;length > 0 but less than 128. use the xmme (lower halves) and exit

