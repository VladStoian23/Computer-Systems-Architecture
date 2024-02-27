bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;16. e=(a+b)/2 + (10-a/c)+b/4 data types: a,b,c - byte, d - word

    a db 5
    b db 7
    c db 5
    d dw 10

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;a+b
        movzx eax, byte [a]  ; 
        movzx ebx, byte [b]  ; 
        movzx ecx , byte [c];
        
        add eax,ebx;
        ;eax=a+b
        shr eax,1; eax=a+b/2
        
        mov edx,10;
        idiv ecx; divide edx:eax to ecx :(a/c) result in EAX
        sub eax,edx;10=a/c
        
        add eax,ebx;
        ;a+b)/2 +10-a/c
        shr ebx,2;
        ;b/4
        add eax,ebx;
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
