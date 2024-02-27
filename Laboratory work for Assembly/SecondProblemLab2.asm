bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; 100*(a+b)-3/(c+d)+e; a,c-word; b,d-byte; e-doubleword;
    a dw 10
    b db 5
    c dw 1
    d db 2
    e dd 1
    ; 100*15 -1 +1 =1500
; our code starts here
segment code use32 class=code
    start:
    
        mov ax, [a]      ; load the word 'a' into ax
        movzx bx, byte [b]  ; load the byte 'b' into bx, zero-extend to 16 bits
        add ax, bx       ; ax = ax + bx
        imul ax, 100     ; ax = ax * 100
        
        mov cx,[c];c is in CX
        movzx dx,byte [d];d is in dx
        add cx,dx;
        mov ax,3
        idiv cx;ax=ax/cx
        
        ;+e dw
        add eax,[e];

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
