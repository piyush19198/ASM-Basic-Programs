%macro display 4
   mov rax,%1
   mov rdi,%2
   mov rsi,%3
   mov rdx,%4
syscall
%endmacro


%macro fopen 1
  mov rax,2
  mov rdi,%1
  mov rsi,2
  mov rdx,0777o
syscall
%endmacro


%macro fread 3
  mov rax,0
  mov rdi,%1
  mov rsi,%2
  mov rdx,%3
syscall
%endmacro


%macro fwrite 3
  mov rax,1
  mov rdi,%1
  mov rsi,%2
  mov rdx,%3
syscall
%endmacro


%macro fclose 1
  mov rax,3
  mov rdi,%1  
syscall
%endmacro





section .data

m1 db 10,"Enter the file name",10
l1 equ $-m1

m2 db 10,"content of the file",10
l2 equ $-m2

m3 db 10,"error in file",10
l3 equ $-m3




section .bss

filename resb 50
filehandle resq 1
buff resb 1024
bufflen equ $-buff
alen resq 1

section .text
global _start
_start:

display 1,1,m1,l1
display 0,0,filename,50

dec rax
mov byte[filename+rax],0

fopen filename
cmp rax,-1h

jle error

mov[filehandle],rax

fread  [filehandle],buff,bufflen
mov [alen],rax

display 1,1,m2,l2
display 1,1,buff,[alen]


jmp exit
error:display 1,1,m3,l3



exit:
mov rax,60
mov rbx,0
syscall




