;使用int10h切换到图形模式下绘制一条水平直线
INCLUDE Irvine16.inc

;--------------------视频模式常量
Mode_06=6	;640*200,2 colors
Mode_0D=0Dh	;320*200,16 colors
Mode_0E=0Eh	;640*200,16 colors
Mode_0F=0Fh	;640*350,2 colors
Mode_10=10h	;640*350,16 colors
Mode_11=11h	;640*480,2 colors
Mode_12=12h	;640*480,16 colors
Mode_13=13h	;640*200,256 colors
Mode_6A=6Ah	;640*600,16 colors

.data
saveMode BYTE ?			;保存当前视频模式
currentX WORD 100		;列号X坐标
currentY WORD 100		;行号Y坐标
COLOR=1001b				;行颜色(青)

progTitle BYTE "DrawLine.asm"
TITLE_ROW=5
TITLE_COLUMN=14

;使用双色模式时,COLOR设为1(白色)
.code
main PROC
	mov ax,@data
	mov ds,ax
	;保存当前视频模式
	mov ah,0Fh
	int 10h
	mov saveMode,al

	;改成图形模式
	mov ah,0
	mov al,Mode_6A
	int 10h

	;以文本方式写程序名
	mov ax,SEG progTitle				;获取progTitle段
	mov es,ax							;保存es中
	mov bp,OFFSET progTitle				
	mvo ah,13h							;功能:写字符串
	mov al,0							;模式:只有字符代码
	mov bh,0							;视频页面:0
	mov bl,7							;属性:normal
	mov cx,SIZEOF progTitle				;字符串长度
	mov dh,TITLE_ROW					;行,字符数
	mov dl,TITLE_COLUMN					;列,字符数
	int 10h

	;画一条直线
	LineLength=100
	mov dx,currentY
	mov cx,LineLength

L1:	push cx
	mov ah,0Ch							;写像素
	mov al,COLOR						;像素颜色,像素值
	mov bh,0							;视频页0
	mov cx,currentX						;CX=x坐标,DX:y坐标
	int 10h
	inc currrentX
	;inc color							;启用查看多颜色行的功能
	pop cx
	Loop L1

	;等待击键
	mov ah,0
	int 16h

	;恢复开始的视频模式
	mov ah,0
	mov al,saveMode						;可以更改为Mode_xx
	int 10h
	exit
main ENDP
END main 

