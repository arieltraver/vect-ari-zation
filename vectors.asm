section .data
    msg db "Hello world!", 0ah
    numbers	db  34,  45,  56,  67,  75, 89

section .text
    global _start

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, 13
    syscall
    mov rax, 60
    mov rdi, 0
    syscall