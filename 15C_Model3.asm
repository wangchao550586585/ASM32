;内存映射图形程序
;视频模式13h,把屏幕像素映射为一个二维字节数组,每个像素单独占用1字节(总共有256种颜色,每个字节指示一种不同颜色).
;数组从屏幕左上角开始,右下角结束
;使用13h使用直接内存映射的方法在屏幕上绘制包括10个像素的行
INCLUDE Irvine16.inc

VIDEO_PALLETE_PORT=3C8h			;视频色彩调色板
COLOR_SELECTION_PORT=3C9h
COLOR_INDEX=1
PALLETE_INDEX_BACKGROUND=0
SET_VIDEO_MODE=0
GET_VIDEO_MODE=0Fh
VIDEO_SEGMENT=0A000h
WAIT_FOR_KEYSTROKE=10h
MODE_13=13h
.data
saveMode BYTE ?
xVal WORD ?							;X坐标
yVal WORD ?							;Y坐标
msg BYTE "Welcome to Mode 13!",0
.code
main PROC
	mov  ax,@data
	mov ds,ax

	call SetVideoMode
	call SetScreenBackground

	mov edx,OFFSET msg
	call WriteString

	call Draw_Some_Pixels
	call RestoreVideoMode
	exit
main ENDP

SetVideoMode PROC
	mov ah,GET_VIDEO_MODE
	int 10h
	mov saveMode,al

	mov ah,SET_VIDEO_MODE
	mov al,MODE_13					;设置模式13h
	int 10h
		
	push VIDEO_SEGMENT				;视频段地址保存到ES
	pop es							
	ret
SetVideoMode ENDP

SetScreenBackground PROC
	mov dx,VIDEO_PALLETE_PORT			;表示要修改的调色板表项
	mov al,PALLETE_INDEX_BACKGROUND		;输出值
	out dx,al							;输出像素和颜色值到视频适配器端口

	;屏幕背景设置为深蓝
	mov dx,COLOR_SELECTION_PORT			;要修改为的颜色值
	mov al,0				;红
	out dx,al
	mov al,0				;绿
	out dx,al
	mov al,35				;蓝(亮度35/63)
	out dx,al
	ret
SetScreenBackground ENDP


Draw_Some_Pixels PROC
	;索引1处颜色改为白色
	mov dx,VIDEO_PALLETE_PORT
	mov al,1				;设置调色板索引1
	out dx,al

	mov dx,COLOR_SELECTION_PORT
	mov al,63				;红
	out dx,al	
	mov al,63				;绿
	out dx,al		
	mov al,63				;蓝
	out dx,al

	;计算第一个像素的视频缓冲区偏移地址,(中心点)
	;分辨率是320*200,中心点是160*100
	mov xVal,160
	mov yVal,100
	mov ax,320
	mul yVal
	add ax,xVal				;ax包含中心点的偏移

	mov cx,10				;绘制10个像素
	mov di,ax
DP1:
	mov BYTE PTR es:[di],COLOR_INDEX
	add di,5				;右移5像素
	loop DP1
	ret
Draw_Some_Pixels ENDP

RestoreVideoMode PROC
	mov ah,WAIT_FOR_KEYSTROKE
	int 16h
	mov ah,SET_VIDEO_MODE
	mov al,saveMode
	int 10h
	ret
RestoreVideoMode ENDP

END main 