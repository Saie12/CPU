section .data
    RAM0 dq 1      ; RAM[0] - multiplier (initialized to 1 for testing)
    RAM1 dq 5      ; RAM[1] - multiplicand (initialized to 5 for testing)
    RAM2 dq 0      ; RAM[2] - result

section .text
global _start

_start:
    mov rax, [RAM0]   ; Load RAM[0] into rax
    mov rcx, [RAM1]   ; Load RAM[1] into rcx
    xor rbx, rbx      ; Clear rbx to use it as the sum
    mov rdx, 0        ; Initialize i = 0

loop_start:
    cmp rdx, rcx
    jge done           ; If i >= RAM[1], exit loop
    add rbx, rax       ; sum += RAM[0]
    inc rdx            ; i++
    jmp loop_start

done:
    mov [RAM2], rbx    ; Store the result in RAM[2]
    mov rax, 60        ; syscall for exit
    xor rdi, rdi       ; status code 0
    syscall             ; call kernel to exit