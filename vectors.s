section .data
    msg db "Hello world!", 0ah
    msg2 db ""

section .text
    global _start

_start:
    mov rsi, msg
    mov rax, 1
    mov rdi, 1
    mov rdx, 13
    syscall        ;NOTE: need to convert the decimal into the letter string to print
    mov rbx, 16
    mov rcx, 8
    imul rbx, rcx ;stored in bx
    mov rcx, rbx
    mov rsi, rcx
    mov [msg2], rbx
    mov rsi, msg2
    mov rax, 1
    mov rdx, 1
    mov rdx, 32
    syscall
    mov rax, 60
    mov rdi, 0
    syscall