 INCLUDE Irvine32.inc
 ;�����û��Զ�������
 PBYTE	TYPEDEF	PTR BYTE
 PWORD	TYPEDEF	PTR WORD
 PDWORD	TYPEDEF	PTR DWORD
.data
 	arrayB	BYTE 10H,20H,30H
	arrayW  WORD 1,2,3
	arrayD  DWORD 4,5,6
	
	;����ָ�����
	ptr1 PBYTE arrayB
	ptr2 PWORD arrayW
	ptr3 PDWORD arrayD
.code
mian PROC
 	mov esi,ptr1
	mov al,[esi]
	mov esi,ptr2
	mov ax,[esi]
	mov esi,ptr3
	mov eax,[esi]
 	exit
main ENDP
END main
