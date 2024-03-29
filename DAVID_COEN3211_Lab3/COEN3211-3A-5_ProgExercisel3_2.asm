.model small
.code
    org 100h
    call clrregs
    jmp main
    
.data 
    text    db "R. M. Mondala","$"     
    str_len dw ?
    str_row db ?
    str_col db ?
    
main:
    mov ax, @data
    mov es, ax
    mov str_len, 13
    mov str_row, 5
    mov str_col, 14
    
main1:
    lea bp, text
    call disp_string
    dec str_len
    inc str_row
    cmp str_len, 0
    call delay
    jne main1   
    call delay 
    call disp_string
    call exit

disp_string proc near
    mov ah, 13h
    mov al, 8h
    mov bh, 0  
    mov bl, 82h
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
clrregs endp


clrscr proc near
    mov ax, 06h
    mov al, 0h
    mov bl, 82h
    mov ch, 0
    mov cl, 0
    mov dh, 24
    mov dl, 79
    int 10h
    ret
clrscr endp

delay proc near
    mov cx, 003fh
  d: nop
  loop d
  ret
delay endp


exit proc ner 
    mov ah, 4ch
    int 21h
    ret
exit endp


end main



     
    