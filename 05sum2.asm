;����3����,ʹ��USES
INCLUDE Irvine32.inc
.data
	array DWORD 10000h,20000h,30000h,40000h,50000h
	theSum DWORD ?
.code
main PROC
	mov esi,OFFSET array
	mov ecx,LENGTHOF array
	call ArraySum
	mov theSum,eax
main ENDP
;---------------------
ArraySum PROC
;
;����32λ�����
;Receives: ESI=����ƫ��
;		   ECX=�������
;Returns:  EAX=�����ܺ�
;---------------------
	push esi
	push ecx
	mov eax,0
    
 L1:add eax,[esi]			;eax�洢���
	add esi,TYPE DWORD		;ָ����һ������
	loop L1

	pop ecx
	pop esi
	ret
ArraySum ENDP


ArraySum2 PROC USES esi ecx
	mov eax,0
    
 L1:add eax,[esi]			
	add esi,TYPE DWORD		
	loop L1

	ret
ArraySum2 ENDP

END main