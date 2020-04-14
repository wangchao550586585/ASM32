;显示彩色字符串
INCLUDE Irvine16.inc
.data
ATTRIB_HI=10000000b
string BYTE "ABCDEFGHIJKLMOP"
color  BYTE	(black SHL 4) OR blue
.code
main PROC
	mov ax,@data
	mov ds,ax

	call Clrscr
	call EnableBliking			;可选
	mov cx,SIZEOF string
	mov si,OFFSET string

L1:	push cx
	mov ah,9					;显示字符/属性
	mov al,[si]					;显示字符
	mov bh,0					;视频页0
	mov bl,color				;属性
	or bl,ATTRIB_HI				;设置闪烁/亮度位
	mov cx,1					;显示一次
	int 10h
	mov cx,1					;前进光标至
	call AdvanceCursor			;屏幕上的下一列
	inc color					;下一个颜色
	inc si						;下一个字符
	pop cx						
	loop L1
	call Crlf
	exit
main ENDP

EnableBliking PROC
	push ax
	push bx
	mov ax,1003h		;切换闪烁/亮度
	mov bl,1			;允许闪烁
	int 10h
	pop bx
	pop ax
	ret
EnableBliking ENDP

AdvanceCursor PROC
	pusha

L1:	push cx
	mov ah,3				;获取光标位置
	mov bh,0				;视频页0
	int 10h					;改变cx寄存器(光标起始,结束扫描线),位置值到DH,DL中
	inc	dl					;列增加
	mov ah,2				;设置光标位置
	int 10h
	pop cx
	loop L1

	popa
	ret
AdvanceCursor ENDP
END main 