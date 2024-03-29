.model small

.code
    org 0100h
        call clr_regs
        jmp drill_exer1
        
.data
    first_char equ 'A'
    stop_char  equ '['

 drill_exer1:   mov al, first_char
    next_char:  call print_char
                call disp_del
                inc al
                cmp al, stop_char
                jne next_char
                call exit
                
 print_char proc near
    mov ah, 02h
    mov dl, al
    int 21h
    ret
 print_char endp
 
 clr_regs proc near
    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx
    ret
 clr_regs endp
 
 exit proc near
    mov ah, 4ch
    int 21h
    ret
 exit endp
 
 disp_del proc near
            mov cx, 000fh
    del:    nop
            loop del
            ret
 disp_del endp
 
end drill_exer1