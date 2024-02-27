bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)   `
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment     data use32 class=data
    ; a –word, b – byte, c  - word, d – byte
    a dw 10
    b db 11
    c dw 20
    d db 5

; our code starts here
segment code use32 class=code
    start:
        ; c-(b-a)+3+d
        mov al,[b]; al= 10
        mov ah,0; ah=al extins 
       
       
        mov bx,[a]; bx=word 10
        sub ax,bx ; (b-a)
        
        mov cx,[c]
        sub cx,ax ; c-(b-a)=20-1=19
        
        add cx,3
        
        ;pt a aduna d -byte il mutam in dl dupa in dx (mov dh,0 adunam cx , dx
        
        mov dl,[d]
        mov dh,0
        
        add cx,dx ; cx=cx+dx =  c-(b-a)+3 + d =22+5 =27 
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
