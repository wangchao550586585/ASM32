;ʹ�ö�̬�ڴ���䴴��һ��1000�ֽڵ�����,ʹ�õ��ǽ��̵�Ĭ�϶�
INCLUDE Irvine32.inc
.data
ARRAY_SIZE=1000
FILL_VAL EQU 0FFh
hHeap HANDLE ?					;���̶ѵľ��
pArray DWORD ?					;�ڴ���ָ��
newHeap DWORD ?					;�¶ѵľ��
str1 BYTE "Heap size is: ",0
.code
main PROC
	INVOKE GetProcessHeap				;��ȡ����Ĭ�϶ѵľ��
	.IF eax==NULL						;ʧ����?
	call WriteWindowsMsg
	jmp quit
	.ELSE
	mov hHeap,eax
	.ENDIF
	call allocate_array
	jnc arrayOk							;ʧ����?(CF=1)
	call WriteWindowsMsg
	call Crlf
	jmp quit
arrayOk:								;�ɹ�,�����������
	call fill_array
	call display_array
	call Crlf

	INVOKE HeapFree,hHeap,0,pArray		;�ͷŴӶ��з�����ڴ��
quit:
	exit
main ENDP

allocate_array PROC USES eax
	INVOKE HeapAlloc,hHeap,HEAP_ZERO_MEMORY,ARRAY_SIZE
	.IF eax==NULL
		stc					;����ʱ,CF=1
	.ELSE		
		mov pArray,eax		;����ָ��
		clc					;����ʱCF=0
	.ENDIF
	ret
allocate_array ENDP

fill_array PROC USES ecx edx esi
	mov ecx,ARRAY_SIZE
	mov esi,pArray
L1:	mov BYTE PTR [esi],FILL_VAL
	inc esi
	loop L1
	ret
fill_array ENDP

display_array PROC USES eax ebx ecx esi
	MOV ecx,ARRAY_SIZE
	mov esi,pArray
L1:	mov al,[esi]
	mov ebx,TYPE BYTE
	call WriteHexB
	inc esi
	loop L1
	ret
display_array ENDP
END main 

