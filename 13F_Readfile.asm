;读取并复制文本文件
.data
BufSize=5000
infile BYTE "my_text_file.text",0
outfile BYTE "my_output_file.text",0
inHandle WORD ?
outHandle WORD ?
buffer BYTE BufSize DUP(?)
bytesRead WORD ?
.code
main PROC
	mov ax,@data
	mov ds,ax

	;打开输入文件
	mov ax,716Ch		;扩展的创建或打开
	mov bx,0			;模式=只读
	mov cx,0			;普通属性
	mov dx,1			;动作:打开
	mov si,OFFSET infile
	int 21h
	jc quit				;发生错误则退出
	mov inHandle,ax

	;读取输入文件
	mov ah,3Fh			;读取文件或设备
	mov bx,inHandle		;文件句柄
	mov cx,BufSize		;最多读取字节数
	mov dx,OFFSET buffer	;缓冲区指针
	int 21h	
	jc quit
	mov bytesRead,ax

	;显示缓冲区
	mov ah,40h		;写文件或设备
	mov bx,1		;控制台输出句柄
	mov cx,bytesRead	;字节数
	mov dx,OFFSET buffer	;缓冲区指针
	int 21h
	jc quit

	;关闭文件
	mov ah,3Eh		;关闭文件
	mov bx,inHandle	;输入文件句柄
	int 21h
	jc quit

	;创建输出文件
	mov ax,716Ch	;扩展的创建或打开
	mov bx,1		;模式=只写
	mov cx,0		;普通属性
	mov dx,12h		;动作:创建/剪裁
	mov si,OFFSET outfile
	int 21h
	jc quit
	mov outHandle,ax

	;缓冲区写入一个新文件
	mov ah,40h			;写文件或设备
	mov bx,outHandle	;输出文件句柄
	mov cx,bytesRead	;字节数
	mov dx,OFFSET buffer	;缓冲区指针
	int 21h
	jc quit
	
	;关闭文件
	mov ah,3Eh		;关闭文件
	mov bx,outHandle	;输出文件句柄
	int 21h

quit:
	call Crlf
	exit
main ENDP
END main 