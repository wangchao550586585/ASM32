--------------Ã°ÅÝ
BubbleSort PROC	USES eax ecx esi,
			pArray:PTR DWORD
			Count:DWORD
	mov ecx,Count
	dec ecx

L1:	push ecx
	mov esi,pArray

L2:	mov eax,[esi]
	cmp [esi+4],eax
	jg L3		
	xchg eax,[esi+4]	;<Ôò½»»»
	mov [esi],eax

L3:	add esi,4
	loop L2

	pop ecx
	loop L1
L4: ret
BubbleSort ENDP