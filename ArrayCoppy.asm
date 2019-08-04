%macro display 4
 	mov rax,%1
 	mov rdi,%2
  	mov rsi,%3
  	mov rdx,%4
 syscall
%endmacro

section .data
 	array1 db 20H,30H,40H,50H,60H
	array2 db 54H,33H,87H,74H,55H
	n equ 5
 	msgs db 10,"Source array is: ",10
 	l1 equ $-msgs
	space db " "
	splen equ $-space
 
	msgdb db 10,"Destination arrray before copying is: ",10
 	l3 equ $-msgdb

 	msgd db 10,"Destination arrray after copying is: ",10
 	l2 equ $-msgd
section .bss
	
	buff resb 2

section .text
global _start
_start:
 display 1,1,msgs,l1
	
	mov rsi,array1	
	call dispblk

	display 1,1,msgdb,l3
	mov rsi,array2
	call dispblk

mov rcx,n
	mov rsi,array1
	mov rdi,array2
	
up3:	mov al,[rsi]
	mov [rdi],al
	inc rsi
	inc rdi
	loop up3
	
	display 1,1,msgd,l2
	mov rsi,array2
	call dispblk
	mov rax,60
	mov rbx,0
	
			
	syscall	 
 
dispblk: 
	mov rbp,n
up1:    push rsi
	mov al,[rsi]
	call display8
	pop rsi 
	inc rsi 
	dec rbp 
	jnz up1
	ret
	
	
	

display8:
	mov rsi,buff
	mov rcx,2
up2:	rol al,4
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
	display 1,1,buff,2
	display 1,1,space,splen
ret	  

