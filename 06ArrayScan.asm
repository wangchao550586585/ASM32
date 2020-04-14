;查找16位数组中第一个非零值
INCLUDE Irvine32.inc
.data
;intArray	SWORD	0,0,0,0,1,20,35,-12,66,4,0
intArray	SWORD	0,0,0,0
noneMsg	BYTE "A non-zero value was not found",0
.code
main PROC
	mov ebx,OFFSET intArray
	mov ecx,LENGTHOF intArray
 L1:cmp WORD PTR [ebx],0
	jnz found
	add ebx,2
	loop L1
	jmp notFound

found:
	movsx eax,WORD PTR[ebx]
	call WriteInt
	jmp quit
notFound:
	mov edx,OFFSET noneMsg
	call WriteString
quit:
	call Crlf
	exit

main ENDP
END main
