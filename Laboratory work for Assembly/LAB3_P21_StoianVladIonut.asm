bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; d-[3*(a+b+2)-5*(c+2)] data types: a,b,c - byte, d - wor =40-3*5+5*3=40
    a db 1
    b db 2
    c db 1
    d dw 40
; our code starts here
segment code use32 class=code
    start:
        ; 
            movzx eax,byte [a];eax=1
            movzx ebx,byte [b];ebx=2
            movzx ecx,byte [c];ecx=1
            movzx edx,word [d];edx=40
            
           ; a + b + 2
        add eax, ebx
        add eax, 2
        ;(a+b+2) *3
        imul eax, 3

        ; c + 2
        add ecx, 2
        ;ecx=3
        imul ecx, 5

        ; Subtract the results and store in edx
        sub edx, eax ; edx = d - [3 * (a + b + 2)]
        ;sub edx, ecx ; edx = d - [3 * (a + b + 2) - 5 * (c + 2)]
        ;or
        add edx,ecx;because of the - before the paranthesis 
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
