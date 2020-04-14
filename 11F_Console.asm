;控制台输出
INCLUDE Irvine32.inc
.data
endl EQU <0dh,0ah>
message LABEL BYTE
	BYTE "This program is a simple demonstration of "
	BYTE "console mode output, using the GetStdHandle "
	BYTE "and WriteConsole functions.", endl
messageSize DWORD ($-message)
consoleHandle HANDLE 0			;标准输出设备的句柄
bytesWritten DWORD ?			;已输出的字符数量
.code
main PROC
	INVOKE GetStdHandle,STD_OUTPUT_HANDLE
	mov consoleHandle,eax	  
	INVOKE WriteConsole		  ,	
	consoleHandle			  ,;控制台输出句柄
	ADDR message			  ,;字符串指针
	messageSize				  ,;字符串长度
	ADDR bytesWritten		  ,;返回实际输出的字符数量
	0						   ;未用
	INVOKE ExitProcess,0
main ENDP
END main 