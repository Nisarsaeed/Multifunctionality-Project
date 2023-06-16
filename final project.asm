include 'emu8086.inc'
.model small
.stack 100h 
.data
    arr db 7  dup('?')
	str1 db 100 DUP('$')
	lengthOfString db ?
	str2 db "Enter String: $"
	power db 128, 64, 32, 16, 8, 4, 2, 1  
    binary_num db 8 dup(0)
    decimal_num dw 0
    student_id db 0
    student_name db 20 dup(' ')
    email_address db 30 dup(' ')
    phone_number db 12 dup(' ')
    father_name db 30 dup(' ')
    file_name db 'example.txt', 0 
.code

main proc 
    
    mov ax,@data
	mov ds,ax
    lable1e:
    putc 0ah  
    putc 0dh
    print 'Enter your choice-->'
    putc 0ah  
    putc 0dh
    print '1.Binary To Decimal'
    putc 0ah  
    putc 0dh
    print '2.Arithmatic Operations' 
    putc 0ah  
    putc 0dh
    print '3.Decimal to Binary'
    putc 0ah  
    putc 0dh
    print '4.Logical Operations'
    putc 0ah  
    putc 0dh
    print '5.Student Reg System' 
    putc 0ah  
    putc 0dh
    print '6.Check Time?'
    putc 0ah  
    putc 0dh
    print '0.Close'
    putc 0ah  
    putc 0dh 
    mov ah,1
    int 21h
    cmp al,'1'
    je Convertore
    cmp al,'2'
    je Calculatore
    cmp al,'3'
    je Palindromee
    cmp al,'4'
    je Log
    cmp al,'5'
    je Timee
      cmp al,'6'
    je systemtime
    cmp al,'0'
    je Clos 
    jmp Wronge1
    
    Convertore:
    putc 0ah  
    putc 0dh
    call convertor
    jmp lable1e
    
    Calculatore:
    putc 0ah  
    putc 0dh
    call calc  
    jmp lable1e
    
    Palindromee:
    putc 0ah  
    putc 0dh
    call btd
    
    jmp lable1e
    Timee:
    putc 0ah  
    putc 0dh
    call student
    jmp lable1e
    
    systemtime: 
     putc 0ah  
    putc 0dh
    call Time
    jmp lable1e
    
    log:
    call logopr
    jmp lable1e
    

    Wronge1:
    putc 0ah
    putc 0dh
    print 'Wrong Choice ...'
    putc 0ah
    putc 0dh
    jmp Lable1e
    Clos:
    putc 0ah
    putc 0dh
    Print 'Byeee'
main endp
Time proc
Print 'Time = '
mov ax, @data
mov ds, ax
hour:
mov ah, 2ch
int 21h
mov al, ch
aam          
mov bx, ax
call disp
mov dl, ':'
mov ah, 02h
int 21h
minutes:
mov ah, 2ch
int 21h
mov al, cl
aam
mov bx, ax
call disp
mov dl, ':'
mov ah, 02h
int 21h
seconds:
mov ah, 2ch
int 21h
mov al, dh
aam
mov bx, ax
call disp

disp:
mov dl, bh
add dl, 30h
mov ah, 02h
int 21h
mov dl, bl
add dl, 30h
mov ah, 02h
int 21h
ret
Time endp
BTD proc    
    mov ax, @data
    mov ds, ax
    print 'Enter a binary number (input<=1001): '
 
    
    mov si, offset binary_num
    add si,4  
    mov cx, 4                 
    
input_loop:
    mov ah, 01h       
    int 21h         
    
    cmp al, 0dh       
    je convert        
    
    sub al, 30h      
    mov [si], al      
    
    inc si          
    loop input_loop   
    
convert:
    mov si, offset binary_num   
    mov cx, 8                   
    mov bx, offset power        
    mov ax, 0                   
    
convert_loop:
    mov dl, [si]      
    mov al, [bx]     
    
    mul dl          
    add decimal_num, ax   
    
    inc si           
    inc bx           
    loop convert_loop   
    

    mov bx, decimal_num
    mov ah, 02h       
    mov dl, 0        
    display_loop:
        mov dx, 0       
        mov ax, bx      
        mov bx, 10      
        div bx          
        add dl, 30h     
        push dx        
        test ax, ax     
        jnz display_loop  
        mov cx,1
        putc 0ah
        putc 0dh
        print 'Result = '
        pop dx          
        mov ah, 02h     
        int 21h        
        
ret
BTD endp

convertor proc 
    mov ax,@data
    mov ds,ax
    mov si,offset arr
    mov si,0
    print 'Enter Decimal Number(Two digits) : '
    mov ah,1
    int 21h
    sub al,30h
    mov bl,10
    mul bl
    mov bh,al
    
    mov ah,1
    int 21h
    sub al,30h
    add al,bh
     
    mov dh,al
    mov bl,2
    la1:
    mov ah,0 
    mov al,dh 
    div bl
    mov arr[si],ah
    inc si
    mov dh,al
    mov bh,ah    
    cmp dh,1
    jge la1   
    putc 0ah
    putc 0dh
    mov cx,si
    print 'In Binary : '
    lable:
    dec si      
    mov dl,arr[si] 
    mov ah,2
    add dl,30h
    int 21h
    loop lable
    exit:
 ret   
convertor endp    

Calc proc
    Lable1:
    putc 0ah  
    putc 0dh
    print 'Enter your choice'
    putc 0ah  
    putc 0dh
   
    print '1.Addition'
    putc 0ah  
    putc 0dh
    print '2.Subtraction' 
    putc 0ah  
    putc 0dh
    print '3.Multiplication'
    putc 0ah  
    putc 0dh
    print '4.Divide'
    putc 0ah  
    putc 0dh 
    print '5.Square'
    putc 0ah  
    putc 0dh
    print '0.Close'
    putc 0ah  
    putc 0dh 
    mov ah,1
    int 21h
    cmp al,'1'
    je Addition
    cmp al,'2'
    je Subtraction
    cmp al,'3'
    je Multiplication
    cmp al,'4'
    je Divide
     cmp al,'5'
    je square
    cmp al,'0'
    je Close 
    jmp Wrong
    
    Addition:
    putc 0ah  
    putc 0dh
    print 'For Addition --> '
    putc 0ah
    putc 0dh
    print 'Enter Value 1: '
    mov ah,1
    int 21h
    mov bl,al
    putc 0ah  
    putc 0dh
    print 'Enter Value 2: '
    mov ah,1
    int 21h
    putc 0ah  
    putc 0dh
    print 'Result = '
    add al,bl
    mov dl,al
    sub dl,30h 
    mov ah,2
    int 21h
    jmp Lable1
    
    
    Subtraction:
    putc 0ah  
    putc 0dh
    print 'For Subtraction --> '
    putc 0ah
    putc 0dh
    print 'Enter Value 1: '
    mov ah,1
    int 21h
    add al,30h
    mov bl,al
    putc 0ah  
    putc 0dh
    print 'Enter Value 2: '
    mov ah,1
    int 21h 
    add al,30h
    putc 0ah  
    putc 0dh
    print 'Result = ' 
    sub bl,al
    mov dl,bl
    add dl,30h
    mov ah,2
    int 21h
    jmp Lable1
    
    
    Multiplication:
    putc 0ah  
    putc 0dh
    print 'For Multiplication --> '
    putc 0ah
    putc 0dh
    print 'Enter Value 1: '
    mov ah,1
    int 21h
    sub al,30h
    mov bl,al
    putc 0ah  
    putc 0dh
    print 'Enter Value 2: '
    mov ah,1
    int 21h
    sub al,30h
    putc 0ah  
    putc 0dh
    print 'Result = '
    mul bl
    mov bl,10
    div bl
    mov bl,ah
    mov dl,al
    add dl,30h
    mov ah,2 
    int 21h
    mov dl,bl
    add dl,30h
    mov ah,2 
    int 21h

    jmp Lable1
    
     divide: 
     print 'Enter Denominator ' 
 
  mov ah, 01h
  int 21h
  sub al, 30h
  mov bl, al 
  putc 0ah
  putc 0dh

  print 'Enter numerator '
  mov ah, 01h
  int 21h
  sub al, 30h    ; Subtract 30h to convert from ASCII to decimal
  xor ah, ah    ; Clear AH before division
  div bl        ; Divide the numerator by the denominator
  putc 0ah
  putc 0dh
  print 'Qoutient = ' 
  add al, 30h   ; Convert the quotient to ASCII
  mov dl, al
  mov ah, 02h
  int 21h
  jmp Lable1
  
    square:
    
     putc 0ah
putc 0dh
print 'For Squaring Calculation --> '
putc 0ah
putc 0dh
print 'Enter Value: '
mov ah, 01h
int 21h
sub al, 30h
mov bl, al
putc 0ah
putc 0dh
;print 'Result = '
mul bl
mov cl,ah    
mov dl, al 
add dl, 30h 
mov ah, 2
int 21h

mov dl, cl 
add dl, 30h
mov ah,2 
int 21h

    jmp Lable1
    
    Wrong:
    putc 0ah
    putc 0dh
    print 'Wrong Choice ...'
    putc 0ah
    putc 0dh
    jmp Lable1
    Close:
    putc 0ah
    putc 0dh
    Print 'Byeee'
    ret 
calc endp

LogOpr proc  
    opr:
    putc 0ah  
    putc 0dh
    print '1.Xor'
    putc 0ah  
    putc 0dh
    print '2.Or' 
    putc 0ah  
    putc 0dh
    print '3.And'
    putc 0ah  
    putc 0dh      
    print '0.Close'
    putc 0ah  
    putc 0dh 
    
    mov ah,1
    int 21h
    cmp al,'1'
    je Xorr
    cmp al,'2'
    je orr
    cmp al,'3'
    je Andd
   
    cmp al,'0'
    je Closee 
    jmp Wrng 
    
    Xorr:
    putc 0ah
    putc 0dh
    print 'Enter Value_1: '
      mov ah,1
    int 21h
    sub al,30h
    mov bl,al
    putc 0ah
    putc 0dh
    print 'Enter Value_2: ' 
    mov ah,1
    int 21h
    sub al,30h
    
    xor al,bl
     mov dl,al
    add dl,30h
    putc 0ah
    putc 0dh
    print 'Result = '
    mov ah,2
    int 21h
    jmp opr
    orr:   
     putc 0ah
    putc 0dh  
     print 'Enter Value_1: '
     mov ah,1
    int 21h
    sub al,30h
    mov bl,al
    putc 0ah
    putc 0dh 
    print 'Enter Value_2: '
    
    mov ah,1
    int 21h
    sub al,30h
      or al,bl
      mov dl,al
    add dl,30h
    mov ah,2
    int 21h
    jmp opr 
    Andd:   
    putc 0ah
    putc 0dh
    print 'Enter Value_1: '
    mov ah,1
    int 21h
    sub al,30h
    mov bl,al
    putc 0ah
    putc 0dh 
    print 'Enter Value_2: '
    
    mov ah,1
    int 21h
    sub al,30h
      and al,bl
    mov dl,al
    add dl,30h
    mov ah,2
    int 21h
    jmp opr
    
    
    Wrng:
    putc 0ah
    putc 0dh
    print 'Wrong Choice ...'
    putc 0ah
    putc 0dh
    jmp opr
    Closee:
    putc 0ah
    putc 0dh
    Print 'Byeee'
    
    ret
    LOgopr endp
    
    
    
    
student proc
    mov ax, @data
    mov ds, ax
     
    print 'Student Registration System-->'  
    putc 0ah
    putc 0dh  
    
    print 'Enter student ID: '
    mov ah, 01h     
    int 21h         
    
    mov student_id, al
    putc 0ah
    putc 0dh
    
    print 'Enter student name: '
    mov si, offset student_name
    mov cx, 20    
    input_loopy:
        mov ah, 01h     
        int 21h          
        cmp al, 0dh       
        je process_email    
        mov [si], al      
        inc si            
        loop input_loopy  
    putc 0ah
    putc 0dh
    
process_email:

    print 'Enter Email Address   : '
    mov si, offset email_address
    mov cx, 30       
    input_email_loop:
        mov ah, 01h      
        int 21h           
        cmp al, 0dh       
        je process_phone_number   
        mov [si], al       
        inc si            
        loop input_email_loop    
    putc 0ah
    putc 0dh

process_phone_number:       

    print 'Enter phone number: '
    mov si, offset phone_number
    mov cx, 12       
    input_phone_number_loop:
        mov ah, 01h     
        int 21h      
        cmp al, 0dh     
        je process_father_name   
        mov [si], al      
        inc si            
        loop input_phone_number_loop  
    putc 0ah
    putc 0dh

process_father_name: 

    print 'Enter father name: '
    mov si, offset father_name
    mov cx, 30      
    input_father_name_loop:
        mov ah, 01h       
        int 21h           
        cmp al, 0dh      
        je save_to_file  
        mov [si], al     
        inc si           
        loop input_father_name_loop  
    putc 0ah
    putc 0dh

save_to_file:
    mov al, student_id
    add al, 30h      

    
    mov ah, 3ch    
    mov cx, 0        
    mov dx, offset file_name
    int 21h           
    
    mov bx, ax     

    
    mov ah, 40h       
    mov cx, 1          
    mov dx, offset student_id
    int 21h          

   
    mov ah, 40h        
    mov cx, 20         
    mov dx, offset student_name
    int 21h          

    
    mov ah, 40h        
    mov cx, 30         
    mov dx, offset email_address
    int 21h           

   
    mov ah, 40h     
    mov cx, 12     
    mov dx, offset phone_number
    int 21h           

   
    mov ah, 40h        
    mov cx, 30        
    mov dx, offset father_name
    int 21h          

   
    mov ah, 3eh        
    mov bx, ax         
    int 21h           

    print 'Registration successful!'
    putc 0ah
    putc 0dh
    
    print 'Student ID: '
    mov dl, al
    add dl,30h
    mov ah, 02h       
    int 21h
    putc 0ah
    putc 0dh
    print 'Student Name: '
    mov si, offset student_name
    display_loopy:
        mov al, [si]    
        cmp al, ' '   
        je end_display  
        mov dl, al
        mov ah, 02h     
        int 21h
        inc si          
        jmp display_loopy 

end_display:
    mov ax, 4c00h     
    int 21h
 ret
student endp



