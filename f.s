;xmm0 - v0 
;xmm1 - alfa 
;xmm2 - k
;xmm3 - g 
;xmm4 - time step 


global quadratic_drag

section .data
	two : dd 2.0

section .text

quadratic_drag : 
	push rbp 
	mov rbp, rsp 
	
	;~ mov r8, rsi 
	;~ mov r9, rdx
	
	;vx
	movsd [rsp -64], xmm1
	fld qword [rsp -64]
	fcos 
	fstp qword[rsp -64]
	movsd xmm5, [rsp -64] 
	mulsd xmm5, xmm0 
	
	;vy
	movsd [rsp -64], xmm1
	fld qword [rsp -64]
	fsin
	fstp qword[rsp -64]
	movsd xmm6, [rsp -64] 
	mulsd xmm6, xmm0 
	
	
	cvtsd2si r13, xmm5 ;vx
	cvtsd2si r14, xmm6 ;vy 
	shl r14, 3 
	
	mov r11, 0
	
	
	mov r15, rdi
	mov r10, 8632
	mov r11, 0 
	add r15, r10 

	
	;r10 1080 -pos y
	;r11 pos x 
	;r13 vx
	;r14 vy
loop: 

	mov r15, rdi 
	
	;new v0
	movsd xmm0, xmm5
	mulsd xmm0, xmm0 
	movsd xmm1, xmm6 
	mulsd xmm1, xmm1
	addsd xmm0, xmm1 
	sqrtsd xmm0, xmm0
	cvtsd2si r12, xmm0 ;v0
	
	
	;new vy xmm6 
	movsd xmm7, xmm0
	mulsd xmm7, xmm6
	mulsd xmm7, xmm2 
	addsd xmm7, xmm3
	mulsd xmm7, xmm4 
	subsd xmm6, xmm7 
	cvtsd2si r14, xmm6 ;vy 
	shl r14, 3 
	
	;new vx xmm5
	movsd xmm7, xmm0 
	mulsd xmm7, xmm2
	mulsd xmm7, xmm5 
	mulsd xmm7, xmm4 
	subsd xmm5, xmm7 
	cvtsd2si r13, xmm5 
	
vel: 	

	sub r10, r14
	cmp r10, 8632
	jg end
	cmp r11, 1920
	jg end
	add r15, r10
	
	
	mov rbx, [r15] 
	
	;new vx ;xmm5
	
	
	add r11, r13
	add rbx, r11

	
	mov al, 255 
	mov [rbx], al

	jmp loop
	

end : 	
	mov rsp, rbp
	pop rbp 
	
ret 
