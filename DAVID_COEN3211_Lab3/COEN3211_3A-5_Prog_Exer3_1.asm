.model small 

.code
    org 100h
    call clrregs
    jmp progexer1
    
.data
    pixcol    dw 0
    pixrow    dw 0
    scr_mode  db 13h
    attribute db 0
    str_len   dw ?
    str_row   db ?
    str_col   db ?
    text      db "DAVID'S HOUSE", "$"
    
 progexer1: mov ax, @data
            mov ds, ax
                 
            mov attribute, 20h
            call clrscr
            call setscrmode
            call bgcolor
            
            mov str_len, 13
            mov str_row, 2
            mov str_col, 12                
            lea bp, text
            call setcursor
            
            call disp_string
            call textdelay
            
            mov pixrow, 120
            mov pixcol, 80
 dline1:    call delay
            call setpixpos
            inc pixcol
            dec pixrow
            cmp pixcol, 150
            jne dline1
            
 dline2:    call delay
            call setpixpos
            inc pixrow
            inc pixcol
            cmp pixcol, 220
            jne dline2 
 
 vline1:    call delay
            call setpixpos
            inc pixrow
            cmp pixrow, 190
            jne vline1
            
 hline1:    call delay
            call setpixpos
            dec pixcol
            cmp pixcol, 80
            jne hline1
            
 vline2:    call delay
            call setpixpos
            dec pixrow
            cmp pixrow, 120
            jne vline2
 
 hline2:    call delay
            call setpixpos
            inc pixcol
            cmp pixcol, 220
            jne hline2 
            
            call setpause
            call clrscr  
            
            mov scr_mode, 03h
            call setscrmode
            call exit
            
 setpixpos proc near
    mov ah, 0Ch
    mov al, 0Eh
    mov bh, 0
    mov cx, pixcol
    mov dx, pixrow
    int 10h
    ret
 setpixpos endp
 
 setpause proc near
    mov ah, 00h
    mov bh, 00h
    int 21h
    ret
 setpause endp
 
 setcursor proc near
    mov ah, 02h
    mov bh, 0
    mov dh, str_row
    mov dl, str_col
    int 10h
    ret
  setcursor endp
 bgcolor proc near
    mov ah,09h
    mov bh,0
    mov al,20h
    mov cx,800h
    mov bl,20h
    int 10h
    ret
 bgcolor endp
 
 disp_string proc near
    mov ah, 13h
    mov al, 01h
    mov bh, 0
    mov bl, attribute
    mov cx, str_len
    mov dh, str_row
    mov dl, str_col
    int 10h
    ret
 disp_string endp
 
 clrscr proc near
        mov ax, 06h
        mov al, 00h
        mov bh, attribute
        mov ch, 0
        mov cl, 0
        mov dh, 24
        mov dl, 79
        int 10h
        ret
 clrscr endp
       
 clrregs proc near
    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx
    ret
 clrregs endp 
 
 setscrmode proc near
    mov ah, 00h
    mov al, scr_mode
    int 10h
    ret
 setscrmode endp
 
 delay proc near
        mov cx, 0001h
    d:  nop
        loop d
        ret
 delay endp
 
 textdelay proc near
        mov cx, 00ffh
    td:  nop
        loop td
        ret
 textdelay endp
 
 exit proc near
    mov ah, 4ch
    int 21h
    ret
 exit endp
 
 end progexer1