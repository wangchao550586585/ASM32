;ʹ�ö�̬����ѭ������2000����Լ0.5MB���ڴ��
INCLUDE Irvine32.inc
.data
HEAP_START=20000000
HEAP_MAX=400000000
BLOCK_SIZE=500000
hHeap HANDLE ?
pData DWORD ?
str1 BYTE 0dh,0ah,"Memory allocation failed",0dh,0ah,0
.code
main PROC
	INVOKE HeapCreate,0,HEAP_START,HEAP_MAX
	.IF eax==NULL
	call WriteWindowsMsg
	call Crlf
	jmp quit
	.ELSE
	mov hHeap,eax
	.ENDIF
	mov ecx,2000
L1:	call allocate_block			;����һ���ڴ�
	.IF Carry?					;ʧ����?
		mov edx,OFFSET str1
		call WriteString
		jmp quit
	.ELSE						;��,��ӡһ����
		mov al,'.'				;��ʾ����
		call WriteChar
	.ENDIF

	;call free_block			;��ע��/��ע�͹۲�Ч��
	loop L1

quit:
	INVOKE HeapDestroy,hHeap	;���ٶ�
	.IF eax==NULL
	call WriteWindowsMsg
	call Crlf
	.ENDIF

	exit 
main ENDP

allocate_block PROC	 USES ecx
	;����һ�����0���
	INVOKE HeapAlloc,hHeap,HEAP_ZERO_MEMORY,BLOCK_SIZE
	.IF eax==NULL
		stc
	.ELSE 
		mov pData,eax
		clc
	.ENDIF
	ret
allocate_block ENDP

free_block PROC	USES ecx
	INVOKE HeapFree,hHeap,0,pData
	ret
free_block ENDP

END main 