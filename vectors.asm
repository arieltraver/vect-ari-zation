section .data
    msg db "Hello world!", 0ah

section .text
    global _start

_start:
    mov rsi, msg
    mov rax, 1
    mov rdi, 1
    mov rdx, 13
    syscall        ;NOTE: need to convert the decimal into the letter string to print
    mov rax, 16
    mov rcx, 8
    imul rcx, rax
    lea rsi, [rcx]
    mov rax, 1
    mov rdi, 1
    mov rdx, 3
    syscall
    mov rax, 60
    mov rdi, 0
    syscall