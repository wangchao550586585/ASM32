INCLUDE Irvine32.inc	
.data
	Rval SDWORD ?
	Xval SDWORD 26
	Yval SDWORD 30
	Zval SDWORD 40

.code
subadd PROC
	;Rval=-Xval+(Yval-Zval)
	mov eax,Xval
	neg eax
	mov ebx,Yval
	sub ebx,Zval
	add eax,ebx
	mov Rval,eax

	;零标志
	mov cx,1
	sub cx,1			;ZF=1
	mov ax,0FFFFh
	inc ax				;ZF=1

	;符号标志
	mov cx,0
	sub cx,1			;SF=1
	mov ax,7FFFh
	add ax,2			;SF=1

	;进位标志
	mov al,0FFh
	add al,1			;CF=1,AL=00

	;溢出标志
	mov al,+127
	add al,1			;OF=1
	mov al,-128
	sub al,1			;OF=1

subadd ENDP
END subadd
