;显示时间
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
	mov ah,2Ah		;获取系统时间
	int 21h
	movzx eax,dh			;月
	call WriteDec
	INVOKE Write,"-"
	movzx eax,dl			;日
	call WriteDec
	INVOKE Write,"-"
	movzx eax,cx			;年
	call WriteDec

	;显示日期
	mov dx,OFFSET str2
	call WriteString
	mov ah,2Ch				;获取系统时间
	int 21h
	movzx eax,ch
	call WritePaddedDec		;小时
	INVOKE Write,':'
	movzx eax,cl
	call WritePaddedDec		;分钟
	INVOKE Write,':'
	movzx eax,dh
	call WritePaddedDec		;秒
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