--------------���ֲ���
BinarySearch PROC	uses ebx edx esi edi
	pArray:PTR DWORD
	Count:DWORD
	searchVal:DWORD
	LOCAL first:DWORD,
		  last:DWORD
		  mid:DWORD
	
	mov first,0
	mov eax,Count
	dec eax
	mov last,eax
	mov edi,searchVal
	mov ebx,pArray

	;while first<=last
L1:	mov eax,first
	cmp eax,last
	jg L5		;���first>last,��exit

	;mid=(last+first)/2
	mov eax,last
	add eax,first
	shr eax,1
	mov mid,eax

	;EDX=values[mid]
	mov esi,mid
	shl esi,2			;DWORDռ��2�ֽ�,ƫ��*2=ʵ��ƫ�Ƶ�ַ
	mov edx,[ebx+esi]

	;if(EDX<searchVal)
	cmp edx,edi
	jge L2			;edx>=edi
	;first=mid+1
	mov eax,mid
	inc eax
	mov first,eax
	jmp L4

	;else if(EDX>searchVal)
L2:	cmp edx,edi
	jle L3
	;last=mid-1
	mov eax,mid
	dec
	mov last,eax
	jmp L4

L3: mov eax,mid
	jmp L9				 ;�ҵ�����eax
L4:jmp L1				
L5:mov eax,-1			;û�ҵ�,��������-1
L9:ret
BinarySearch ENDP
