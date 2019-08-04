
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
	nline		db	10
	nline_len	equ	$-nline

	

	m1	db	10,"Enter filename "
	l1	equ	$-m1	

	m2	db	10,"output is "
	l2	equ	$-m2	
  
	errmsg	db	10,"ERROR ",10
	errmsg_len	equ	$-errmsg

	
section .bss
	buf			resb	1024
	buf_len		equ	$-buf		; buffer length

	filename		resb	50	

	filehandle		resq	1
	abuf_len		resq	1		; actual buffer length

	array			resb	10
	n			resb	1
;--------------------------------------------------------------------------
section .text
	global _start
		
_start:
				

		display 1,1,m1,l1		
		display 0,0,filename,50
		dec rax
		mov byte[filename+rax],0		; blank char/null char

		fopen filename				; on succes returns handle
		cmp	rax,-1H				; on failure returns -1
		je	Error
		mov	[filehandle],rax	

		fread	[filehandle],buf,buf_len
		dec	rax					; EOF
		mov	[abuf_len],rax

		call	bsort
		jmp	Exit

Error:	display 1,1,errmsg,errmsg_len

Exit:		mov rax,60
mov rbx,0
syscall
;-------------------------------------------------------------------------------- 
bsort:							; Bubble sort procedure
		call	buf_array

		xor	rax,rax
		mov	rbp,[n]
		dec	rbp

		xor	rcx,rcx
		xor	rdx,rdx
		xor	rsi,rsi
		xor	rdi,rdi

		mov	rcx,0				; i=0

oloop:	mov	rbx,0				; j=0

		mov	rsi,array			; a[j]

iloop:	mov	rdi,rsi			; a[j+1]
		inc	rdi

		mov	al,[rsi]
		cmp	al,[rdi]
		jbe	next

		mov	dl,0
		mov	dl,[rdi]			; swap
		mov	[rdi],al
		mov	[rsi],dl

next:		inc	rsi
		inc	rbx				; j++
		cmp	rbx,rbp
		jb	iloop
		
		inc	rcx
		cmp	rcx,rbp
		jb	oloop

	fwrite	[filehandle],m2,l2
	fwrite	[filehandle],array,[n]

	fclose [filehandle]	

		RET


buf_array:
	xor	rcx,rcx
	xor	rsi,rsi
	xor	rdi,rdi
	mov	rcx,[abuf_len]
	mov	rsi,buf
	mov	rdi,array

n1:
	mov	al,[rsi]
	mov	[rdi],al

	inc	rsi		; number
	inc	rsi		; newline
	inc	rdi

	inc	byte[n]	; counter
	dec	rcx		; number
	dec	rcx		; newline
	jnz	n1
ret
;------------------------------------------------------------------
