section .data
    R0 db 5          ; First number
    R1 db 4          ; Second number
    R2 db 0          ; Result storage
    i db 1           ; Initialize i = 1
    sum db 0         ; Initialize sum = 0

section .text
global main          ; Declare the main function as global
extern ExitProcess   ; Import ExitProcess from kernel32.dll

main:
    ; Start of the loop
LOOP:
    movzx rax, byte [i]  ; Load i into RAX
    movzx rbx, byte [R1]  ; Load R1 into RBX
    cmp rax, rbx          ; Compare i with R1
    jge STOP              ; If i >= R1, jump to STOP

    ; sum += R0
    movzx rax, byte [sum] ; Load sum into RAX
    movzx rbx, byte [R0]  ; Load R0 into RBX
    add rax, rbx          ; sum += R0
    mov [sum], al         ; Store the new sum back

    ; i++
    inc byte [i]          ; Increment i
    jmp LOOP              ; Jump back to the start of the loop

STOP:
    ; Store result in R2
    movzx rax, byte [sum] ; Load sum into RAX
    mov [R2], al          ; Store sum in R2

    ; Exit the program
    mov eax, 0            ; Return code 0
    call ExitProcess       ; Call ExitProcess to exit