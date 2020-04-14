INCLUDE Irvine32.inc
.data
arrayD		DWORD 1000h,2000h,3000h
prompt1		BYTE "Enter a 32-bit signed integer: ",0
dwordVal	DWORD ?

.code
main PROC
		;使用DumpMem过程显示数组的内容
		mov eax,yellow+(blue*16)
		call SetTextColor
		call Clrscr					;清除颜色
		;设置文本颜色为蓝底黄字
		mov esi,OFFSET arrayD
		mov ecx,LENGTHOF arrayD
		mov ebx,TYPE arrayD
		call DumpMem
		call Crlf					;换行

		;提示用户输入一个十进制整数
		mov edx,OFFSET prompt1
		call WriteString
		call ReadInt
		mov dwordVal,eax

		;以十/十六/二进制显示整数
		call Crlf
		call WriteInt
		call Crlf
		call WriteHex
		call Crlf
		call WriteBin
		call Crlf
		call WaitMsg

		;将控制台窗口设为默认颜色
		mov eax,lightGray+(black*16)
		call SetTextColor
		call Clrscr					;清除屏幕
		exit
main ENDP
END main