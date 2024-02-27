bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
        S dd 12345678h,1a2b3c4dh
        S_len equ $-S
        
        R db 0,0,0,0 ; for the high bytes
        R_len equ $-R

; our code starts here
segment code use32 class=code
    start:
        ; ...
       mov esi,S;
       mov edi,R;
       
       mov ecx,S_len/4;nr of dwords
       jecxz _done;if there are no dw the nits done
       
            _extract_loop:
                mov eax,[esi]
                ;extract the high byte drom the low word
                mov al,ah
                ;store the result in R
                mov [edi],al
       
                ;move to the next dw
                add esi,4
                add edi,1
       
                ;decrease the loop counter
                loop _extract_loop
       
      _done:
      ;the result is now in R
      mov eax,1
      xor ebx,ebx
       
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
