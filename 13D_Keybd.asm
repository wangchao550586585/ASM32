;���ļ�or�豸��ȡ�ֽ�����,����Ӽ��̶�,�س�Ҳ�ᱻ��ȡ,0Da��0Ah׷�ӵ�������ĩβ
FlushBuffer PROC
	.data
		oneByte BYTE ?
	.code
		push a
	L1:	
		mov ah,3Fh		;��ȡ�ļ�/�豸
		mov bx,0		;���,0��ʾ����
		mov cx,1
		mov dx,OFFSET oneByte
		int 21h
		cmp oneByte,0Ah	;���ѽ���?
		jne L1			;��?������ȡ
		popa 
		ret
FlushBuffer ENDP
