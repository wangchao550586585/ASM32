;笛卡尔坐标程序
INCLUDE Irvine16.inc

Mode_6A=6Ah					;800*600,16色
X_axisY=300
X_axisX=50
X_axisLen=700

Y_axisY=400
Y_axisY=30
Y_axisY=540

.data
saveMode BYTE ?
.code
main PROC
	mov ax,@data
	mov ds,ax

	;保存当前视频模式
	mov ah,0Fh
	int 10h
	mov saveMode,al

	;切换到图形模式
	mov ah,0
	mov al,Mode_6A		;800*600,16色
	int 10h

	;绘制X轴
	mov cx,X_axisX		;线条起始X坐标
	mov dx,X_axisY		;线条起始Y坐标
	mov ax,X_axisLen	;线条长度
	mov bl,white		;线条颜色
	call DrawHorizLine	;绘制线条

	;绘制Y轴
	mov cx,Y_axisX		
	mov dx,Y_axisY
	mov ax,Y_axisLen
	mov bl,white
	call DrawVerticalLine

	;等待击键
	mov ah,10h
	int 16h

	;恢复开始的视频模式
	mov ah,0
	mov al,saveMode
	int 10h
	
	exit
main ENDP

DrawHorizLine PROC
	.data
	currX WORD ?
	.code
		pusha
		mov currX,cx
		mov cx,ax
	DHL1:
		push cx
		mov al,bl			;颜色
		mov ah,0Ch			;写像素
		mov bh,0			;视频页0
		mov cx,currX		;CX=x坐标,DX:y坐标
		int 10h
		inc currX
		pop cx
		Loop DHL1
		popa
		ret
DrawHorizLine ENDP

DrawVerticalLine PROC
	.data
	currY WORD ?
	currX WORD ?
	.code
		pusha
		mov currY,dx
		mov currX,cx
		mov cx,ax
	DHL1:
		push cx
		mov al,bl			;颜色
		mov ah,0Ch			;写像素
		mov bh,0			;视频页0
		mov dx,currY		;CX=x坐标,DX:y坐标
		mov cx,currX
		int 10h
		inc currY
		pop cx
		Loop DHL1
		popa
		ret
DrawVerticalLine ENDP
END main 
