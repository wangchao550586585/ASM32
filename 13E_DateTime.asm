;��ʾʱ��
INCLUDE Irvine16.inc
Write PROTO char:BYTE
.data
str1 BYTE "Date: ",0
str2 BYTE ", Time: ",0
.code
main PROC
	mov ax,@data
	mov ds,ax

	mov dx,OFFSET str1
	call WriteString
	mov ah,2Ah		;��ȡϵͳʱ��
	int 21h
	movzx eax,dh			;��
	call WriteDec
	INVOKE Write,"-"
	movzx eax,dl			;��
	call WriteDec
	INVOKE Write,"-"
	movzx eax,cx			;��
	call WriteDec

	;��ʾ����
	mov dx,OFFSET str2
	call WriteString
	mov ah,2Ch				;��ȡϵͳʱ��
	int 21h
	movzx eax,ch
	call WritePaddedDec		;Сʱ
	INVOKE Write,':'
	movzx eax,cl
	call WritePaddedDec		;����
	INVOKE Write,':'
	movzx eax,dh
	call WritePaddedDec		;��
	call Crlf
	exit

main ENDP

Write PROC char:BYTE
	push eax
	push edx

	mov ah,2
	mov dl,char
	int 21h
	
	pop edx
	pop eax
	ret
	

Write ENDP

WritePaddedDec PROC
	.IF eax<10
		push eax
		push edx
		mov ah,2
		mov dl,'0'
		int 21h
		pop edx
		pop eax
	.ENDIF
	call WriteDec
	ret
WritePaddedDec ENDP
END main 