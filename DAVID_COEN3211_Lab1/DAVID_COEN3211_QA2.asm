.model small                                            

.code
    org 100h
    jmp start

.data
    completeName db "DAVID, Raven A. ",10,13, "$"
    schoolName db 09h, "Colegio de Muntinlupa ", 10, 13, "$" 
    department db 09h, 09h, "BS Computer Engineering Student ", 10,13, "$" 
    courseCode db 09h, 09h, 09h, "COEN3211 - Microprocessors Lab $", 10,13, "$"
    
start:   
    lea dx, completeName 
    call print_string
      
    lea dx, schoolName
    call print_string
    
    lea dx, department
    call print_string
    
    lea dx, courseCode
    call print_string
    
    call exit    
    
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
    
end start    


