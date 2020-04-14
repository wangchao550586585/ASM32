;计算数组和并在EAX返回
INCLUDE Irvine32.inc
.code

ArraySum PROC,
	ptrArray:PTR DWORD,
	arraySize:DWORD

	push ecx
	push esi

	mov eax,0
	mov esi,ptrArray
	mov ecx,arraySize
	cmp ecx,0
	jle L2

L1:	add eax,[esi]
	add esi,4
	loop L1

L2:	pop esi
	pop ecx

	ret 
ArraySum ENDP
END