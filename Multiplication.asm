%macro display 4
 	mov rax,%1
 	mov rdi,%2
  	mov rsi,%3
  	mov rdx,%4
 syscall
%endmacro

section .data

	msg1 db 10,"Enter the fist number: ",10
 	l1 equ $-msg1
	msg2 db 10," Enter the second number: ",10
 	l2 equ $-msg2
	msg3 db 10," The multiplication of numbers are ",10
 	l3 equ $-msg3 


section .bss
	numascii resb 3
	num1 resb 2
	num2 resb 2
	buff resb 4

section .text
global _start
_start:
	display 1,1,msg1,l1
	display 0,0,numascii,3
	call asciitohex
	mov [num1],bl
	display 1,1,msg2,l2
	display 0,0,numascii,3
	call asciitohex
	mov [num2],bl
	mov rax,0
	mov rbx,0
	mov rcx,0
	mov al,[num1]
	mov bl,[num2]
	
up1:	add cx,ax
	dec bl
	jnz up1
	
	mov ax,cx
	call display16
		
	mov rax,60
	mov rbx,0
syscall
	
	
asciitohex:
	mov rsi,numascii
	mov rcx,2
	mov rbx,0
up:	rol bl,4	
	mov dl,[rsi]
	cmp dl,39H
	jbe sub30
	sub dl,07H
sub30:	sub dl,30H
	add bl,dl
	inc rsi
	loop up	
	ret

display16:
	mov rsi,buff
	mov rcx,4
up2:	rol ax,4
	mov dl,0
	mov dl,al
	and dl,0fh
	cmp dl,09h
	jbe add30
	add dl,07h

add30:add dl,30h
	mov [rsi],dl
	inc rsi
	loop up2
	display 1,1,msg3,l3
	display 1,1,buff,4
	ret	  

