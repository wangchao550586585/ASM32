;清空键盘缓冲区不是特定的按键,如游戏控制清除一些并没有意义的按键
;按下的任何键都会被忽略并从键盘缓冲区删除,一直到接收ESC时程序终止
INCLUDE Irvine16.inc
ClearKeyboard PROTO,scanCode:BYTE
ESC_key=1							;扫描码
.code
main PROC
	L1:
		;间隔300ms在屏幕上显示一个圆点
		mov ah,2
		mov dl,'.'
		int 21h
		mov eax,300						;延时300ms
		call Delay
		INVOKE ClearKeyboard,ESC_KEY	;检查ESC键
		jnz L1						;如果ZF=0,则继续循环
	quit:
		call Clrscr
		exit
main ENDP

ClearKeyboard PROC,scanCode:BYTE
	push ax
L1:	mov ah,11h					;检查键盘缓冲区
	int 16h						;按下任何一个键了么?
	jz noKey					;否:退出
	mov ah,10h					;是,从缓冲区删除
	int 16h		
	cmp ah,scanCode				;是否是退出按键?
	je quit						;是:退出,且ZF=1
	jmp L1						;否:在检查缓冲区
noKey:							;无按键
	or al,1						;清除零标志
quit:
	pop ax
	ret
ClearKeyboard ENDP
END main 
