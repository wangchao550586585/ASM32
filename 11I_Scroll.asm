;在屏幕缓冲区上显示50行文本,然后控制控制台窗口位置和大小,达到有效滚动文字效果
INCLUDE Irvine32.inc
.data
message BYTE ": This line of text was written"
	    BYTE "to the screen buffer",0dh,0ah
messageSize DWORD ($-message)
outHandle HANDLE 0						;标准输出句柄
bytesWritten DWORD ?					;已写的字节数
lineNum		 DWORD 0
windowRect	SMALL_RECT <0,0,60,11>		;左上右下
.code
main PROC
	INVOKE GetStdHandle,STD_OUTPUT_HANDLE
	mov outHandle,eax
.REPEAT
	mov eax,lineNum
	call WriteDec
	INVOKE WriteConsole,			
		outHandle,				;控制台输出句柄
		ADDR message,			;字符串指针
		messageSize,			;字符串长度
		ADDR bytesWritten,		;返回已写的字节数
		0						;未用
	inc lineNum					;下一行的行号
.UNTIL lineNum>50

	INVOKE SetConsoleWindowInfo,
		outHandle,					;屏幕输出句柄
		TRUE,						;坐标类型,TRUE:坐标代表控制台窗口新的左上角和右下角位置,FALSE则新坐标加到当前控制台坐标上
		ADDR windowRect				;指向窗口矩形的坐标
	call ReadChar			;等待按键
	call Clrscr				;清除屏幕缓冲区
	call ReadChar			;等待第二次按键
	INVOKE ExitProcess,0

main ENDP
END main 
