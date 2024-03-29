.model small

.code
    org 100h 
    call clrregs
    jmp start
 
.data
    scr_mode      db 13h 
    question      db 'Enter a number >> ', "$"
    string_length dw ?
    row_coor      db ? 
    col_coor      db ?
    row           db ?
    col           db ?
    input         db ?  
    char_val      db '*********', "$"  
    loop_count    db ?       

start: 
    mov ax, @data
    mov ds, ax     
    
    ;INITIALIZE VIDEO MODE   
    call video_mode          
    call set_bg
    
    ;PROMPT QUESTION
    mov string_length, 18
    mov row_coor, 2 
    mov col_coor, 2
    lea bp, question
    call disp_string
    
    ;READ INPUT 
    call read_char         ;READ CHAR WITHOUT ECHO, THEN RE-PRINT USING 13H OF INT 10H 
    mov input, al
    lea bp, input  
    mov string_length, 1
    mov row_coor, 2
    mov col_coor, 20
    call disp_string    
    
    ;INPUT CHECKER - IF ZERO, RESET 
    cmp input, '0' 
    je start
    
    ;START PRINTING
    lea bp, char_val    
    mov string_length, 1
    mov row_coor, 4
    mov col_coor, 2
    
    mov loop_count, 0 
    
pyramid: 
    call disp_string 
    
    inc string_length
    inc row_coor 
    
    inc loop_count
    mov al, loop_count
    add al, '0' 
               
    cmp al, input    
    jne pyramid
    
    jmp loop_exit
    
loop_exit:
    call exit

;SUBROUTINES - INCLUDING 00H, 06H AND 0AH
clrregs proc near
    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx
    ret
clrregs endp 

video_mode proc near
    mov ah, 00h
    mov al, scr_mode
    int 10h
    ret
video_mode endp

clr_scr proc near
    mov ah, 06h    
    mov al, 00    
    mov bh, 00h     
    mov ch, 0 
    mov cl, 0
    mov dh, 24
    mov dl, 79  
    int 10h 
    ret
clr_scr endp  

set_cursor proc near
    mov ah, 02h
    mov bh, 0
    mov dh, row
    mov dl, col
    int 10h
    ret
set_cursor endp

set_bg proc near
    mov ah, 09h
    mov bh, 0
    mov bl, 20h
    mov al, 20h
    mov cx, 800h   
    int 10h
    ret
set_bg endp 

disp_string proc near
    mov ah, 13h
    mov al, 01
    mov bh, 0
    mov bl, 21h 
    mov cx, string_length
    mov dh, row_coor
    mov dl, col_coor
    int 10h
    ret
disp_string endp 

read_char proc near
    mov ah, 08h
    int 21h
    ret
read_char endp 

exit proc near
    mov ah, 4ch
    int 21h
    ret
exit endp

end start
         