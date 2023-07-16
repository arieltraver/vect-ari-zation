;source of mulby10: https://stackoverflow.com/questions/4361979/how-does-the-gcc-implementation-of-modulo-work-and-why-does-it-not-use-the

section .data
    msg db "Hello world!", 0ah
    msg2 db ""

section .text
    global _atoi

;rdi will hold the integer.
_atoi:
            push rbx
            push rbp

divideby10: movl    -4(ebp), ecx
            movl    -858993459, edx
            movl    ecx, eax
            mull    edx
            shrl    3, edx

mulby10:    movl    %edx, %eax   ; eax=i/10
            sall    $2, %eax     ; eax=(i/10)*4
            addl    %edx, %eax   ; eax=(i/10)*4 + (i/10) = (i/10)*5
            addl    %eax, %eax   ; eax=(i/10)*5*2 = (i/10)*10

printout:   mov rsi, msg2
            mov rax, 1
            mov rdx, 1
            mov rdx, 64 ;print the whole buffer
            syscall
            mov rax, msg2 ;rax is the return value
            pop rbp
            pop rbx ;pop rbx off the stack
            ret