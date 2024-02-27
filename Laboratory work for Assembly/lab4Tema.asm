bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;a byte, b word, c word, d byte, e doubleword, f byte
    ;if (c-a) <= 10 then e = 5* (b+1) else e = 12/(a-6)
    a db 4
    b dw 3
    c dw 10
    e dd 0
    

; our code starts here
segment code use32 class=code
    start:
         ; Compare (c - a) with 10
    mov eax, [c]
    sub eax, [a]
    cmp eax, 10

    ; Jump to label else_block if (c - a) > 10
    jg else_block

    ; If (c - a) <= 10, calculate e = 5 * (b + 1)
    mov eax, [b]
    add eax, 1
    imul eax, 5
    mov [e], eax
    jmp end_if

else_block:
    ; If (c - a) > 10, calculate e = 12 / (a - 6)
    mov eax, [a]
    sub eax, 6
    mov ebx, 12
    idiv ebx
    mov [e], eax

end_if:
    ; Exit the program
    push dword 0
    call exit  ; call exit to terminate the program
