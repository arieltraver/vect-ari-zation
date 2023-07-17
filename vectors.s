global _start

section .data
	arr0 dword 1.1, 2.2, 3.3, 4.4
	arr1 dword 5.5, 6.6, 7.7, 8.8
	zeros dword 0, 0, 0, 0
section .text
_start:
	movups xmm0, arr0 ;move first array
	movups xmm1, arr1
	mulps xmm0, xmm1
	


