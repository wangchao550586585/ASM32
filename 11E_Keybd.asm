;获取键盘单个按键的状态
INCLUDE Irvine32.inc
INCLUDE Macros.inc
.code
main PROC
	INVOKE GetKeyState,VK_NUMLOCK
	test al,1
	.IF !Zero?
		mWrite <"The NumLock key is ON",0dh,0ah>
	.ENDIF
	INVOKE GetKeyState,VK_LSHIFT
	test al,80h
	.IF !Zero?
		mWrite <"The Left Shift key is currently DOWN",0dh,0ah>
	.ENDIF
	exit
main ENDP
END main 