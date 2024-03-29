.model small

.code
    org 100h
    jmp start
    
.data 
    firstDigit db "Enter the first single digit number: ",20h, "$"
    secondDigit db 10, 13, "Enter the second single digit number: ", 20h, "$" 
    
    resultKeyOne db 10, 13, "The sum of ", "$"
    resultKeyTwo db " and ", "$"
    resultKeyThree db " is ", "$"   
    
    numOne db ?
    numTwo db ?
    sum db ?
    
    placeholderOne db ?
    placeholderTwo db ?
    
start:
    lea dx, firstDigit
    call print_string
    call read_char
    sub al, '0'
    mov numOne, al
    
    lea dx, secondDigit
    call print_string
    call read_char
    sub al, '0'
    mov numTwo, al   
    
    mov al, numOne
    add al, numTwo
    mov sum, al
    
    cmp sum, 9
    jg disp_two_digits_sum
    
    jmp disp_sum
    
disp_two_digits_sum:
    call disp_result
    
    mov al, 1
    add al, '0'
    mov dl, al
    call print_char
    
    sub sum, 10
    add sum, '0'
    mov dl, sum
    call print_char
    call exit
    
disp_sum:
    call disp_result
    
    add sum, '0'
    mov dl, sum
    call print_char
    call exit
    
disp_result proc near
    lea dx, resultKeyOne
    call print_string
    
    add numOne, '0'
    mov dl, numOne
    call print_char 
    
    lea dx, resultKeyTwo
    call print_string
    
    add numTwo, '0'
    mov dl, numTwo
    call print_char 
    
    lea dx, resultKeyThree
    call print_string
    ret
disp_result endp    
                                  
print_char proc near
    mov ah, 02h
    int 21h
    ret 
print_char endp

print_string proc near
    mov ah, 09h
    int 21h
    ret
print_string endp

read_char proc near
    mov ah, 01h
    int 21h
    ret
read_char endp

exit proc near
    mov ah, 4ch
    int 21h
    ret
exit endp

disp_del proc near
      mov cx, 000Fh
 del: nop
      loop del
      ret
disp_del endp

end start




