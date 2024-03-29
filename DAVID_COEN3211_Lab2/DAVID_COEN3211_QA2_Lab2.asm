.model small

.code
    org 100h 
    call clr_regs
    jmp start
    
.data
    fullName db "DAVID, Raven A. ", 10,13, "$"
    schoolName db "Colegio de Muntinlupa ", 10,13, "$"
    courseName db "BS Computer Engineering ", 10,13, "$"
    courseCode db "COEN 3211 - Microprocessors (Lab) ", 10,13, "$"  
    
    attri db 0
    col db 0
    row db 0
    
start: 
    mov attri, 9Eh
    call clr_scr
    
    mov row, 9
    mov col, 31
    call set_cursor
    
    lea dx, fullName
    call print_string
    call disp_del
    
    mov row, 10
    mov col, 28
    call set_cursor
    
    lea dx, schoolName
    call print_string
    call disp_del 
    
    mov row, 11
    mov col, 27
    call set_cursor
    
    lea dx, courseName
    call print_string
    call disp_del
    
    mov row, 12
    mov col, 22 
    call set_cursor
    
    lea dx, courseCode
    call print_string
    call disp_del 
    
    call exit
    

;DOS/BIOS FUNCSTIONS :: SUB-ROUTINES
set_cursor proc near
       mov ah, 02h
       mov bh, 0
       mov dh, row
       mov dl, col
       int 10h
       ret
set_cursor endp

clr_scr proc near
        mov ah, 06h    
        mov al, 00     
        mov bh, attri  
        mov ch, 0
        mov cl, 0
        mov dh, 24
        mov dl, 79
        int 10h
        ret
clr_scr endp   

clr_regs proc near
    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx
    ret
clr_regs endp

print_string proc near
    mov ah, 09h
    int 21h
    ret
print_string endp

exit proc near
    mov ah, 4ch
    int 21h
    ret
exit endp

disp_del proc near
        mov cx, 000Fh
 again: nop
        loop again
        ret
disp_del endp

end start





