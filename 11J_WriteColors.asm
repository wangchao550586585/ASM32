;使用颜色属性
INCLUDE Irvine32.inc
.data
outHandle		HANDLE  ?
cellsWritten	DWORD   ?	
xyPos			COORD	<10,20>
buffer BYTE 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
	   BYTE 16,17,18,19,20
BufSize DWORD ($-buffer)
attributes WORD 0Fh,0Eh,0Dh,0Ch,0Bh,0Ah,9,8,7,6
		   WORD 5,4,3,2,1,0F0h,0E0h,0D0h,0C0h,0B0h
.code
main PROC
	;获取控制台标准输出句柄
	INVOKE GetStdHandle,STD_OUTPUT_HANDLE
	mov outHandle,eax

	;设置相邻连续字符格的颜色
	INVOKE WriteConsoleOutputAttribute,
			outHandle,					;输出句柄
			ADDR attributes,			;颜色属性数组,每个数组低字节存放颜色值
			BufSize,					;输出长度
			xyPos,						;屏幕中接收这些属性的字符格的起始坐标
			ADDR cellsWritten			;填写实际被设置颜色属性的字符格数量

	;输出1-20的字符
	INVOKE WriteConsoleOutputCharacter,
			outHandle,ADDR buffer,BufSize,
			xyPos,ADDR cellsWritten
	INVOKE ExitProcess,0
main ENDP
END main 