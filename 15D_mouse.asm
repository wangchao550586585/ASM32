;鼠标跟踪程序
;鼠标的X和Y坐标随着鼠标的移动在屏幕右下角不断更新,用户按下左键时,鼠标的位置显示在屏幕的左下角
;INCLUDE Irvine16.inc
GET_MOUSE_STATUS=0
SHOW_MOUSE_POINTER=1
HIDE_MOUSE_POINTER=2
GET_CURSOR_SIZE=3
GET_BUTTON_PRESS_INFO=5
GET_MOUSE_POSITION_AND_STATUS=3
ESCkey=1Bh
.data
greeting BYTE "[Mouse.exe] Press Esc to quit",0
statusLine BYTE "Left button: "
		   BYTE "Mouse position: ",0
blanks	   BYTE "                ",0
xCoord WORD 0							;当前X坐标
yCoord WORD 0
xPress WORD 0							;最后按按钮X坐标
yPress WORD 0

;显示坐标
statusRow	BYTE ?
statusCol	BYTE 15
buttonPressCol BYTE 20
statusCol2	BYTE 60
coordCol	BYTE 65

.code 
main PROC
	mov ax,@data
	mov ds,ax
	call Clrscr

	;获取屏幕XY坐标
	call GetMaxXY				;DH=rows,DL=columns
	dec dh						;计算状态行值
	mov statusRow,dh		

	;隐藏文本光标,显示鼠标
	call HideCursor
	mov dx,OFFSET greeting
	call WriteString
	call ShowMousePointer

	;在按钮屏幕行显示状态信息
	mov dh,statusRow			;gotoxy光标移动到指定位置
	mov dl,0
	call Gotoxy				
	mov dx,OFFSET statusLine
	call WriteString

	;循环显示鼠标位置,检查是否按下鼠标左键
	;按下按钮或ESC key
L1:	call ShowMousePosition
	call LeftButtonPress			;检查是否按下鼠标左键
	mov ah,11h						;是否键被按下?
	int 16h
	jz L2							;没有,继续循环
	mov ah,10h						;缓冲区中删除键
	int 16h
	cmp al,ESCkey					;按键是否是ESC
	je quit							;是:退出
L2: jmp L1

quit:
	call HideMousePointer
	call ShowCursor
	call Clrscr
	call WaitMsg
	exit
main ENDP

HideCursor PROC USES ax cx
	mov ah,GET_CURSOR_SIZE
	int 10h
	or ch,30h			;设置鼠标大小为非法值,这样能起到隐藏效果
	mov ah,1			
	int 10h
	ret
HideCursor ENDP

ShowMousePointer PROC USES ax
	mov ax,SHOW_MOUSE_POINTER		;显示鼠标指针
	int 33h
	ret
ShowMousePointer ENDP

ShowMousePosition PROC
	pusha
	
	;如果坐标没有改变,退出过程
	call GetMousePosition
	cmp cx,xCoord					;
	jne L1
	cmp dx,yCoord
	je L2

	;保存新的XY坐标
L1:	mov xCoord,cx
	mov yCoord,dx

	;右下角清空坐标
	mov dh,statusRow
	mov dl,statusCol2
	call Gotoxy
	push dx
	mov dx,OFFSET blanks
	call WriteString
	pop dx

	;右下角显示鼠标XY坐标
	call Gotoxy
	mov ax,xCoord
	call WriteDec
	mov dl,coordCol
	call Gotoxy
	mov ax,yCoord
	call WriteDec

L2:	popa
	ret
ShowMousePosition ENDP

LeftButtonPress PROC
	pusha
	
	mov ax,GET_BUTTON_PRESS_INFO
	mov bx,0
	int 33h

	;如果坐标没有改变则退出
	cmp cx,xPress
	jne L1
	cmp dx,yPress
	je L2

L1: mov xPress,cx
	mov yPress,dx
	

	;左下角清空坐标
	mov dh,statusRow
	mov dl,statusCol
	call Gotoxy
	push dx
	mov dx,OFFSET blanks
	call WriteString
	pop dx


	;左下角显示鼠标XY坐标
	call Gotoxy
	mov ax,xCoord
	call WriteDec
	mov dl,buttonPressCol
	call Gotoxy
	mov ax,yCoord
	call WriteDec

L2: popa
	ret
LeftButtonPress ENDP


HideMousePointer PROC
	mov ax,HIDE_MOUSE_POINTER
	int 33h
	ret
HideMousePointer ENDP

ShowCursor PROC USES ax cx
	mov ah,GET_CURSOR_SIZE
	int 10h
	mov ah,1
	mov cx,0607h
	int 10h
	ret
ShowCursor ENDP

GetMousePosition PROC USES ax
	mov ax,GET_MOUSE_POSITION_AND_STATUS
	int 33h
	ret
GetMousePosition ENDP

END main 

