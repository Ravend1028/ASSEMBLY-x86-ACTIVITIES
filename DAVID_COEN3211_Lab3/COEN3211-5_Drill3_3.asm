.model small

.code
    org 100h
    call clrregs
    jmp main
    
.data
    row      db ?
    col      db ?
    attrib   db ?
    n_scroll db ?
    urow     db ?
    ucol     db ?
    lrow     db ?
    lcol     db ?
    char     db '*'
    msg      db '10 x 10 Asterisk in a Box', '$'
    
main:
    mov ax, @data
    mov ds, ax
    mov attrib, 00h
    call clrscr
    
    mov attrib, 04h
    call clrscr
    mov row, 3
    mov col, 14
    call setcursor
    lea dx, msg
    call printstr
    
    mov attrib, 1Eh
    mov n_scroll, 10
    mov urow, 4
    mov ucol, 24
    mov lrow, 13
    mov lcol, 33
    call setscroll
    
    mov row, 4
    mov col, 24 
    
next:
    call setcursor
    call delay
    call dispchar
    inc row
    cmp row, 14
    jne next
    call exit
    
;SUB-ROUTINES
clrregs proc near
    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx
    ret
clrregs endp

exit proc near
    mov ah, 4ch
    int 21h
    ret
exit endp

clrscr proc near
    mov ax, 06h
    mov al, 00
    mov bh, attrib
    mov ch, 0
    mov cl, 0
    mov dh, 24
    mov dl, 79
    int 10h
    ret
clrscr endp

setscroll proc near
    mov ah, 06h
    mov al, n_scroll
    mov bh, attrib
    mov ch, urow
    mov cl, ucol
    mov dh, lrow
    mov dl, lcol
    int 10h
    ret
setscroll endp

setcursor proc near
    mov ah, 02h
    mov bh, 0
    mov dh, row
    mov dl, col
    int 10h
    ret
setcursor endp

dispchar proc near
    mov ah, 0Ah
    mov al, char
    mov bh, 0
    mov cx, 10
    int 10h
    ret
dispchar endp

printstr proc near
    mov ah, 09h
    int 21h
    ret
printstr endp

delay proc near
    mov cx, 0003h
 d: nop
    loop d
    ret
delay endp 

end main
    