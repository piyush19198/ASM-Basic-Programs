extern printf 
section .data

        array dq 102.5,107.7,10.13,12.15,70.18
        infmt db 10,"Array element:",10,"%e",10,"%e",10,"%e",10,"%e",10,"%e",10,0
        oufmt db 10,"Mean, Varience and standard deviation is:",10,"%e",10,"%e",10,"%e",10
        cnt dw 5

     
        
section .bss

        mean resq 1
        var resq 1
        stdev resq 1
   
    
section .text
global main
main:
        push rbp
        finit
        mov rdi,infmt
        movq xmm0,[array]
        movq xmm1,[array+8]
        movq xmm2,[array+16]
        movq xmm3,[array+24]        
        movq xmm4,[array+32] 
        mov rax,5
        call printf
        
        fldz 
        mov rcx,[cnt]
        mov rbx,array
        mov rsi,00
     up:fld qword[rbx+rsi*8]
        fadd
        inc rsi
        loop up   
        
        
        fidiv word[cnt]
        fstp qword[mean]
      
        fldz
        mov rbx,array
        mov rsi,00
        mov rcx,0
        mov rcx,[cnt]
        
  up1:fldz
        fld qword[rbx+rsi*8]
        fsub qword[mean]
        fst st1
        fmul
        fadd
        inc rsi
        loop up1
        
        fidiv word[cnt]
        fst qword[var]
        
        fsqrt
        fstp qword[stdev]
       
        mov rdi,oufmt
        movq xmm0,[mean]
        movq xmm1,[var]
        movq xmm2,[stdev]
        mov rax,3
        call printf
        pop rbp
        
        mov rax,60
        mov rdi,0
 syscall
        
   
        
