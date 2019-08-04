%macro display 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro



section .data
  
  bcdmsg db 10,"Enter 5 digit bcd number"
  bcdlen equ $-bcdmsg

  hexmsg db 10,"It's equivalence Hexnumber is"
  hexlen equ $-hexmsg



section .bss
   num1 resb 5
   buff resb 4



section .text
global _start
_start:
 
   display 1,1,bcdmsg,bcdlen
   display 0,0,num1,5

   call ascii_to_bcd
   call display1
 
   display 1,1,hexmsg,hexlen
   display 1,1,buff,4

mov rax,60
mov rbx,0
syscall




ascii_to_bcd:
  
  mov rbx,0ah
  mov rcx,5
  mov rax,0

  mov rsi,num1
  
  up:
  mul bx
  mov dl,[rsi]
  sub dl,30h
  add al,dl
  inc rsi
  loop up
  ret


display1:
mov rsi,buff
mov rcx,4

up1:
rol ax,4
mov dl,al
and dl,0Fh
cmp dl,09h
jbe add30
add dl,07h
add30:add dl,30h
mov [rsi],dl
inc rsi 
loop up1
ret
