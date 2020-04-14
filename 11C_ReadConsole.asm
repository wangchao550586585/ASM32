INCLUDE Irvine32.inc
BufSize=80
.data
buffer BYTE BufSize DUP(?),0,0
stdInHandle HANDLE ?
bytesRead   DWORD ?
.code
main PROC
	INVOKE GetStdHandle,STD_INPUT_HANDLE
	mov stdInHandle,eax
	;输入句柄,缓冲区地址指针,读取字符数量,返回实际数量大小的指针(读取操作会包含回车和换行2个额外的字符),保留
	INVOKE ReadConsole,stdInHandle,ADDR buffer,BufSize-2,ADDR bytesRead,0

	mov esi,OFFSET buffer
	mov ecx,bytesRead
	mov ebx,TYPE buffer
	call DumpMem
	exit
main ENDP
END main 
