%macro display 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro

section .data

m1 db 10,"content of msw",10
l1 equ $-m1

m2 db 10,"processor is in real mode",10
l2 equ $-m2

m3 db 10,"processor is in protected mode",10
l3 equ $-m3

m4 db 10,"content of gdtr",10
l4 equ $-m4

m5 db 10,"content of idtr",10
l5 equ $-m5

m6 db 10,"content of ldtr",10
l6 equ $-m6

m7 db 10,"content of tr",10
l7 equ $-m7



section .bss

gdtr resd 1
     resw 1

idtr resd 1
     resw 1

ldtr resw 1
     

tr resw 1
     
buff resb 4



section .text
global _start
_start:


smsw ax

rcr ax,1
jc prmode

display 1,1,m2,l2
jmp next

prmode:display 1,1,m3,l3


next:

display 1,1,m4,l4
sgdt[gdtr]
mov ax,[gdtr+4]
call display64

mov ax,[gdtr+2]
call display64

mov ax,[gdtr]
call display64



display 1,1,m5,l5
sidt[idtr]
mov ax,[idtr+4]
call display64

mov ax,[idtr+2]
call display64

mov ax,[idtr]
call display64



display 1,1,m6,l6
sldt[ldtr]

mov ax,[ldtr]
call display64

display 1,1,m7,l7
str[tr]

mov ax,[ldtr]
call display64



smsw ax
display 1,1,m1,l1
call display64





mov rax,60
mov rbx,0
syscall






display64:

mov rsi,buff
mov rcx,4

up:
rol ax,4
mov dl,al
and dl,0fh

cmp dl,09h
jbe add30

add dl,07h
add30:add dl,30h

mov [rsi],dl
inc rsi
loop up

display 1,1,buff,4
ret

