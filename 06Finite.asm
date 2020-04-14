;分析有符号整数的有限状态机
;---起始--->A---- +/- ---->B---数字--->C<------|
;           |                         ↑ ↓  数字
;           |--------数字-------------|  |-----|

INCLUDE Irvine32.inc
ENTRY_KEY=13
.data
InvalidInputMsg BYTE "Invalid input",13,10,0
.code
main PROC
	call Clrscr

StateA:
	call Getnext			;读取下一个字符送AL
	cmp al,'+'
	je StateB
	cmp al,'-'
	je StateB
	call IsDigit			;如果AL中包含一个数字,ZF=1
	jz StateC
	call DisplayErrorMsg	;发现无效输出
	jmp Quit

StateB:
	call Getnext
	call IsDigit
	jz StateC
	call DisplayErrorMsg
	jmp Quit
StateC:
	call Getnext
	call IsDigit
	jz StateC
	cmp al,ENTRY_KEY
	je Quit
	call DisplayErrorMsg
	jmp Quit
Quit:
	call Crlf
	exit
main ENDP

Getnext PROC
	call ReadChar
	call WriteChar
	ret
Getnext ENDP

DisplayErrorMsg PROC
	push edx
	mov edx,OFFSET InvalidInputMsg
	call WriteString
	pop edx
	ret
DisplayErrorMsg ENDP

END main