.model small

.code
    org 100h  
    call clr_regs
    jmp start 
    
start:
    ;INITIAL CONTENT OF GENERAL REGISTERS
    mov ax, 0AB08h
    mov bx, 06543h
    mov cx, 01203h
    mov dx, 0FACEh
    
    ;INSTRUCTIONS
    add dh, al
    sub ax, dx
    xor bx, ax
    shl al, cl
    rol al, 1
    sub ah, ch   
    neg bx
    xor ax, ax 
    
clr_regs proc near
    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx
    ret
clr_regs endp

end start