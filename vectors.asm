section .data
    msg db "Hello world! result is:", 0ah

section .text
    global _start

_start:
    mov rdi, 1 ; stdout
    mov rsi, msg ;the message
    mov rax, 1 ;syscall for writing
    mov rdx, 25 ;bytes in the message
    syscall
    mov rax, 20
    mov rcx, 23
    mul rcx
    mov rsi, rax
    mov rax, 1
    syscall
    mov rax, 60
    mov rdi, 0
    syscall