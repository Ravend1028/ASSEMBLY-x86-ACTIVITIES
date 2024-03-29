.model small
.code
    org 0100h
    call clr_regs
    jmp drill_exer2

.data
    first_char db ?
    stop_char  db ?
    text1      db 10,"Enter starting lowercase character >> ",20h,"$"
    text2      db 13,10,"Enter stop lowercase character >> ",20h,"$"
    text3      db 13,10,"Output sequence:",20h,"$"
    
 drill_exer2:  lea dx, text1
               call disp_string
               call read_char
               mov first_char, al
               lea dx, text2
               call disp_string
               call read_char
               mov stop_char, al
               lea dx, text3
               call disp_string
               mov dl, first_char
   next_char:  call print_char
               call disp_del
               inc dl
               cmp dl, stop_char
               jne next_char
               call exit
               
 print_char proc near
    mov ah, 02h
    int 21h
    ret
 print_char endp
 
 disp_string proc near
    mov ah, 09h
    int 21h
    ret
 disp_string endp
 
 read_char proc near
    mov ah, 01h
    int 21h
    ret
 read_char endp
 
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
 
end drill_exer2