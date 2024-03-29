.model small

.code
    org 100h
    call clrregs
    jmp main
    
.data
    pixcol dw 0
    pixrow dw 0
    scr_mode db 13h 
    
main:
    mov ax, @data
    mov ds, ax
    
    call clrscr 
    call setscrmode
    
    mov pixrow, 50
    mov pixcol, 100
    
vline:    
    call setdelay
    call setpixpos 
    
    inc pixrow
    cmp pixrow, 180
    jne vline  
    
hline:
    call setdelay
    call setpixpos  
    
    inc pixcol
    cmp pixcol, 240
    jne hline
    
    call setpause
    call clrscr
    
    mov scr_mode, 03h
    call setscrmode
    call exit
      
    
;SUB-ROUTINES
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
    mov bh, 01h
    mov ch, 0
    mov cl, 0
    mov dh, 24
    mov dl, 79
    int 10h
    ret
clrscr endp
;video mode
setscrmode proc near
    mov ah, 00h
    mov al, scr_mode
    int 10h 
    ret
setscrmode endp 

;write pixel dot
setpixpos proc near
    mov ah, 0ch
    mov al, 02h
    mov bh, 0
    mov cx, pixcol
    mov dx, pixrow
    int 10h
    ret
setpixpos endp  

setdelay proc near
    mov cx, 0001h
 x: nop 
    loop x
    ret
setdelay endp

setpause proc near
    mov ah, 08h
    mov bh, 00h
    int 21h
    ret
setpause endp

exit proc near
    mov ah, 4ch
    int 21h
    ret
exit endp

end main