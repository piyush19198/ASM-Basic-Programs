%macro display 4
mov rax,%1 
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro

section .data
  
   msg1 db 10,"Enter 1st 8 bit hex number",10
   l1 equ $-msg1  

   msg2 db 10,"Enter 2nd 8 bit hex number",10
   l2 equ $-msg2
   
   msg3 db 10,"multiplication of two number ",10
   l3 equ $-msg3


section .bss
  
num1 resb 2
num2 resb 2
num3 resb 4
buff resb 4


section .text
global _start
_start: 

display 1,1,msg1,l1
display 0,0,num1,2

call asciitohex
mov [num1],bl

display 1,1,msg2,l2
display 0,0,num2,2

call asciitohex
mov [num2],bl


    mov rax,0
    mov rbx,0
    mov rcx,0

    mov al,[num1]
    mov bl,[num2]

 up1:add cx,ax
     dec bl
     jnz up1
        
     mov ax,cx
 
 call display64
 display 1,1,msg3,l3
 display 1,1,buff,4

  mov rax,60
  mov rbx,0
  syscall









asciitohex:
   mov rsi,[num1]
   mov rcx,2
   mov rbx,0
   
 
   up:
   rol bl,4
   mov dl,[rsi]
   cmp dl,39h
   jbe sub30
 
   sub dl,07h 

   sub30:sub dl,30h
   
   add bl,dl
   inc rsi
   loop up   
   ret

   
 display64:
  mov rsi,[buff]
  mov rcx,4

  up2:
  rol rax,4
  mov dl,al
  and dl,0Fh

  cmp dl,09h
  jbe add30

  add dl,07H
  
  add30:
     add dl,30h
   
  mov [rsi],dl
  inc rsi
  loop up2
  ret
  
