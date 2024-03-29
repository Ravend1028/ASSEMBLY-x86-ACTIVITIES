.model small

.code 
    org 100h
    jmp start
    
.data
    firstChar db ?
    secondChar db ? 
    
    startLetter db "Enter start letter (lowercase letter only): ",20h, "$"
    lastLetter db 10,13,"Enter last letter (lowercase letter only): ",20h, "$"
    resultLetters db 13,10,"Sequence of uppercase characters ", "$" 
    keywordOne db " to ", "$"
    keywordTwo db " in descending order is ",10, 13, "$"  
    whiteSpace db " ", "$"  

start:
    lea dx, startLetter
    call disp_string
    call read_char
    mov firstChar, al
    
    lea dx, lastLetter
    call disp_string
    call read_char
    mov secondChar, al
    
    lea dx, resultLetters
    call disp_string
    mov dl, firstChar
    call print_char
    lea dx, keywordOne
    call disp_string 
    mov dl, secondChar
    call print_char
    lea dx, keywordTwo
    call disp_string
    call disp_del   
    
    mov dl, firstChar
    
    cmp secondChar, dl 
    jl  loop exit
    
    mov dl, firstChar
    sub dl, 32 
    mov firstChar, dl  
       
output:
    mov dl, secondChar
    sub dl, 32  
    call print_char
    call disp_del
    dec byte ptr secondChar
      
    cmp dl, firstChar 
    je loop_exit 
    
    mov dx, offset whiteSpace
    call disp_string
    call disp_del
loop output       
   
loop_exit:    
    call exit  

print_char proc near
    mov ah, 02h
    int 21h
    ret
print_char endp
      
read_char proc near
    mov ah, 01h
    int 21h
    ret
read_char endp  

disp_string proc near
    mov ah, 09h
    int 21h
    ret
disp_string endp

disp_del proc near
    mov cx, 000Fh
 again: nop
        loop again
        ret
disp_del endp

exit proc near
    mov ah, 4ch
    int 21h
    ret
exit endp

end start
