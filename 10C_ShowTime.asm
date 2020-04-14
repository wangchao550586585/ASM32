;获取当前系统时间并在指定屏幕位置上显示,只能在保护模式执行
INCLUDE Irvine32.inc
.data
sysTime SYSTEMTIME <>
XYPos COORD <10,5>
consoleHandle DWORD ?
colonStr BYTE ":",0
.code
main PROC
	;获取win32控制台的标准输出句柄
	INVOKE GetStdHandle,STD_OUTPUT_HANDLE
	mov consoleHandle,eax

	;设置光标位置并获取系统时间
	INVOKE SetConsoleCursorPosition,consoleHandle,XYPos
	INVOKE GetLocalTime,ADDR sysTime

	;显示系统时间
	movzx	eax,sysTime.wHour			;时
	call	WriteDec
	mov		edx,OFFSET colonStr			;":"
	call	WriteString
	movzx	eax,sysTime.wMinute			;分
	call	WriteDec
	call	WriteString
	movzx	eax,sysTime.wSecond			;秒
	call	WriteDec
	call	Crlf
	call	WaitMsg
	exit
main ENDP

END main
