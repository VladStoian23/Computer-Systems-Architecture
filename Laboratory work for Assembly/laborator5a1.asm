bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;   If A = 2, 3, 4 => B = 5, 7
        A db 2,3,4
        A_len equ $-A
        B db 0,0,0;initialize with zeros for the sum value
        B_len equ $-B
; our code starts here
segment code use32 class=code
    start:
       mov esi,A;Source index for A
       mov edi,B;Dest index for B
       
       mov ecx,A_len-1;loop counter
       jecxz _done
       
        _add_loop:
            mov al,[esi]
            mov bl,[esi+1]
     
            add al,bl
            mov [edi],al
     
            add esi,1;we used two numbers 
            add edi,1;size of the array in B?
     
            loop _add_loop
     _done:
     ;the resault will be in string B
     
       mov eax,1
       xor ebx,ebx
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
