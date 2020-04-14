;输入三个值计算和,并显示
INCLUDE Irvine32.inc
INTEGER_COUNT=3
.data
array DWORD INTEGER_COUNT DUP(?)
str1 BYTE "Enter a signed integer: ",0
str2 BYTE "The sum of the integer is: ",0
.code
main PROC
	call Clrscr
	mov esi,OFFSET array
	mov ecx,INTEGER_COUNT
	call PromptForIntegers
	call ArraySum
	call DisplaySum
	exit
main ENDP

PromptForIntegers PROC USES ecx edx esi
	mov edx,OFFSET str1
 L1:call WriteString
	call ReadInt
	call Crlf
	mov [esi],eax
	add esi,TYPE DWORD
	loop L1
	ret
PromptForIntegers ENDP

ArraySum PROC USES esi ecx
	mov eax,0
 L1:add eax,[esi]
	add esi,TYPE DWORD
	loop L1
	ret
ArraySum ENDP

DisplaySum PROC	USES edx
	mov edx,OFFSET str2
	call WriteString
	call WriteInt		;display EAX
	call Crlf
	ret
DisplaySum ENDP

END main
