.model small

.code
    org 100h
    call clrregs
    jmp main
    
.data
    text1 db "MICROPROCESSORS LAB", "$"
    text2 db "DRILL EXERCISE 2", "$"
    str_len dw ?
    str_row db ?
    str_col db ?
    
main: 
    mov ax, @data
    mov es, ax
    
    lea bp, text1
    mov str_len, 19
    mov str_row, 12
    mov str_col, 30
    call disp_string
    
    lea bp, text2
    mov str_len, 16
    mov str_row, 13
    mov str_col, 32
    call disp_string  
    
    call delay   
    call clrscr
    call exit
    
    
;SUB-ROUTINES
disp_string proc near
    mov ah, 13h
    mov al, 01h   ;4 vals
    mov bh, 0
    mov bl, 02h 
    mov cx, str_len
    mov dh, str_row
    mov dl, str_col
    int 10h
    ret
disp_string endp 

clrregs proc near
    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx
    ret
clrregs endp

clrscr proc near
    mov ah, 06h
    mov al, 00h
    mov ch, 0
    mov cl, 0
    mov dh, 24
    mov dl, 79
    int 10h
    ret
clrscr endp

delay proc near
    mov cx, 00ffh
 d: nop
    loop d
    ret
delay endp

exit proc near
    mov ah, 4ch
    int 21h
    ret
exit endp  

end main


