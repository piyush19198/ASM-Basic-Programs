;Write 80387 ALP to find the roots of the quadratic equation. All the possible cases must be
;considered in calculating the roots.

section .data

a dq 1.0
b dq 5.0
c dq 6.0
integer4 dw 4.0
m1 db 10,'Root1 is:',10
m2 db 10,'Root2 is:',10
infmt db 10,'a=%e',10,'b=%e',10,'c=%e',10
outfmt db 10,'root1=%e',10,'root2=%e',10

section .bss
temp resq 1
negb resq 1
root1 resq 1
root2 resq 1

extern printf 
section .text
global main
main:
push rbp
finit 
fld qword[b]
fmul qword[b]
fld qword[a]
fmul qword[c]
fimul word[integer4]
fsub
fsqrt
fst qword[temp]
fldz
fsub qword[b]
fst qword[negb]
fld qword[temp]
fadd
fld qword[a]
fadd qword[a]
fdiv 
fstp qword[root1]

fld qword[b]
fmul qword[b]
fld qword[a]
fmul qword[c]
fimul word[integer4]
fsub
fsqrt
fst qword[temp]
fldz
fsub qword[b]
fst qword[negb]
fld qword[temp]
fsub
fld qword[a]
fadd qword[a]
fdiv 
fstp qword[root2]

mov rdi,infmt
movq xmm0,[a]
movq xmm1,[b]
movq xmm2,[c]
mov rax,3
call printf

mov rdi,outfmt
movq xmm0,[root1]
movq xmm1,[root2]
mov rax,2
call printf
pop rbp

mov rax,60
mov rbx,0
syscall
