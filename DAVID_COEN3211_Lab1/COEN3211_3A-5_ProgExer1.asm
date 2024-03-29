.model small

.code
    org 100h
    jmp start   

.data 
    whiteSpace db ' ', '$'
    lowerCase db 'a'
    upperCase db 'A'
    
start:
    mov cx, 26          ; initialize counter register
    mov ah, 02h         ; function to print character
    mov dl, lowerCase
    int 21h             ; DOS Interrupt / execute
    inc byte ptr lowerCase
    call disp_del       
    
    mov ah, 02h         
    mov dl, upperCase
    int 21h               
    inc byte ptr upperCase
    call disp_del 
    
    cmp dl, 'Z'
    je loop_exit
    
    mov ah, 09h         ; function to print string
    mov dx, offset whiteSpace
    int 21h   
loop start
 
loop_exit:
    call exit
    
;subroutine to delay printing    
disp_del proc near
    mov cx, 000Fh
 again: nop
        loop again
        ret
disp_del endp

;subroutine to exit program         
exit proc near         
    mov ah, 4ch
    int 21h
    ret
exit endp

end start