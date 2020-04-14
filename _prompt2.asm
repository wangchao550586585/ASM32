;提示用户输入3个整数,然后值插入数组中
INCLUDE Irvine32.inc
.code
;
PromptForIntegers PROC,
	ptrPrompt:PTR BYTE,
	ptrArray:PTR DWORD,
	arraySize:DWORD

	pushad

	mov ecx,arraySize
	cmp ecx,0			;size<=0
	jle L2				
	mov edx,ptrPrompt		
	mov esi,ptrArray

L1:	call WriteString
	call ReadInt
	call Crlf
	mov [esi],eax
	add esi,4
	loop L1
L2:	popad
	ret 
PromptForIntegers ENDP
END