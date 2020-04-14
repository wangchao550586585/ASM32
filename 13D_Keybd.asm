;从文件or设备读取字节数组,如果从键盘读,回车也会被读取,0Da和0Ah追加到缓冲区末尾
FlushBuffer PROC
	.data
		oneByte BYTE ?
	.code
		push a
	L1:	
		mov ah,3Fh		;读取文件/设备
		mov bx,0		;句柄,0表示键盘
		mov cx,1
		mov dx,OFFSET oneByte
		int 21h
		cmp oneByte,0Ah	;行已结束?
		jne L1			;否?继续读取
		popa 
		ret
FlushBuffer ENDP
