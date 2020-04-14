;ตÝน้
INCLUDE Irvine32.inc
.data
endlessStr BYTE "This recursion never stops",0
.code
main PROC
	call Endless
	exit
main ENDP

Endless PROC
	mov edx,OFFSET endlessStr
	call WriteString
	call Endless
	ret
Endless ENDP
END main