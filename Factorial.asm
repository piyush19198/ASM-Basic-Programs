%macro display 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro



section .data

m1 db 10,"Enter the number",10
l1 equ $-m1

m2 db 10,"factorial of the number",10
l2 equ $-m2

m3 db 10,"the factorial of number is 0001",10
l3 equ $-m3





section .bss

num resb 2
buff resb 16



section .text
global _start
_start:



display 1,1,m1,l1
display 0,0,num,2

call asciitohex

mov [num],dl
mov rax,0
mov rbx,0
mov rcx,0

mov al,[num]
cmp al,01h
jbe next

call fact
call display64


jmp exit
next:display 1,1,m3,l3

exit:

mov rax,60
mov rbx,0
syscall













asciitohex:

mov rsi,num
mov rcx,2
mov dl,0


up:
mov al,0
rol dl,4
mov al,[rsi]
cmp al,39h
jbe sub30

sub al,07h
sub30:sub al,30h
add dl,al
inc rsi
loop up
ret







fact:
cmp rax,01h
je n1
push rax
dec rax
call fact


n2:pop rbx
   mul rbx
   jmp n3

n1:pop rbx
   jmp n2

n3:ret







display64:
mov rsi,buff
mov rcx,16

up2:
rol rax,4
mov dl,al
and dl,0fh
cmp dl,09h
jbe add30

add dl,07h
add30:add dl,30h

mov [rsi],dl
inc rsi
loop up2


display 1,1,buff,16
ret
