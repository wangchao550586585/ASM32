;上卷窗口
INCLUDE Irvine16.inc
.data
message BYTE "Message in Window",0
.code
main PROC
	mov ax,@data
	mov ds,ax
	
	mov ax,0600h				;滚动窗口,ah上卷窗口,al上卷行数(0全部)
	mov bh,(blue SHL 4)OR yellow;空白区域的视频属性,多少行列
	mov cx,050Ah				;左上角,行列位置
	mov dx,0A30h				;右上角,行列位置
	int 10h

	mov ah,2					;设置光标位置
	mov dx,0714h				;行7列20
	mov bh,0					;视频页0
	int 10h

	mov dx,OFFSET message
	call WriteString

	mov ah,10h
	int 16h
	exit
main ENDP
END main 