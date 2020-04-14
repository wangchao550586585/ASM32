;µÝ¹é¼ÆËã1~nµÄÖµ
INCLUDE Irvine32.inc
.code
main PROC
	mov ecx,5
	mov eax,0
	call CalcSum
L1:	call WriteDec
	call Crlf
	exit
main ENDP

CalcSum PROC
	cmp ecx,0
	jz L2
	add eax,ecx
	dec ecx
	call CalcSum
L2:	ret
CalcSum ENDP

END main