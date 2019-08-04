%macro display 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro


section .data 

 hexmsg db 10,'enter 4 digit hex number',10 
 hexlen  equ $-hexmsg 

 bcdno db 10,'its equivalent BCD number is',10
 bcdlen  equ $-bcdno





section .bss

  num1 resb 4
  buff resb 5


section .text
global _start
_start:

    display 1,1,hexmsg,hexlen
    display 0,0,num1,4


call asciitohex 

mov bx,10
mov rcx,0



up1:
mov rdx,0
div bx
push rdx
inc rcx
cmp ax,0
jne up1


mov rsi,buff
up2:
pop rdx
add dl,30h
mov [rsi],dl
inc rsi
loop up2


display 1,1,bcdno,bcdlen
display 1,1,buff,5

mov rax,60
mov rbx,0
syscall





asciitohex:

mov rsi,num1
mov rcx,4
mov rax,0

up:

mov dl,[rsi]
cmp dl,39h
jbe sub30

sub dl,07h

sub30:sub dl,30h

add al,dl
rol ax,4
inc rsi
loop up

ret
 












