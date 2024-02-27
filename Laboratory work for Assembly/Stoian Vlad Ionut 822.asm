bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; a/(b-c)+d         ;10/(6-1)+1=10/5+1=3
    a db 10
    b dw 6
    c db 1
    d dd 1
    

; our code starts here
segment code use32 class=code
    start:
        ; b-c (word - byte)
        mov cl,[c];
        mov ch,0; cx=c
        mov bx,[b];bx=b
        sub bx,cx;bx-cx=b-c=word-word result in bx
        
        ;a/(bx) is byte over word ---> mutam a in dx:ax si impartim wordul  la bx(word)
        movzx ax,byte [a];am convertit a din byte in word 
        
        cwd ; convert word to double word din ax s-a facut dx:ax
        div bx; dx:ax in care se afla "a" se va impartii la bx; rezultatul se afla in dx:ax
        
        push dx;
        push ax;
        pop eax; acum o sa avem in eax a/(b-c)
            
        
        ;adaugam dword eax dword d
        add eax,[d];
        
        ;rezultatul se afla in eax
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
