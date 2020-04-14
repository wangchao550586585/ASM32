;递归计算阶乘
INCLUDE Irvine32.inc
.code 
main PROC
	push 12
	call Factorial

ReturnMain:
	call WriteDec
	call Crlf
	exit
main ENDP

Factorial PROC
	push ebp
	mov ebp,esp

	mov eax,[ebp+8]
	cmp eax,0	;n>0?
	ja L1		;是则递归
	mov eax,1	
	jmp L2		;否则返回1
L1:	dec eax
	push eax
	call Factorial

ReturnFact:
	mov ebx,[ebp+8]
	mul ebx
L2:	pop ebp
	ret 4			;清理堆栈
Factorial ENDP
END main