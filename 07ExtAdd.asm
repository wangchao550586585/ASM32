;��չ�ӷ�
INCLUDE Irvine32.inc
.data
op1 QWORD 0A2B2A40674981234h
op2 QWORD 08010870000234502h
sum DWORD 3 dup(0FFFFFFFFh)
.code
main PROC
	mov esi,OFFSET op1
	mov edi,OFFSET op2
	mov ebx,OFFSET sum
	mov ecx,2
	call Extended_Add

	;Display the sum
	mov eax,sum+8			;��ʾ��λ
	call WriteHex
	mov eax,sum+4			;��ʾ��λ
	call WriteHex
	mov eax,sum				;��ʾ��λ
	call WriteHex
	call Crlf
	exit
main ENDP


;[esi~esi+4*ecx]+[edi~edi+edi+4*ecx]=ebx
Extended_Add PROC
	pushad		;save reg
	clc			;clear the CF
L1:	mov eax,[esi]
	adc eax,[edi]
	pushfd					;�����־�Ĵ���,���а���CF
	mov [ebx],eax
	add esi,4
	add edi,4
	add ebx,4
	popfd
	loop L1

	mov dword ptr[ebx],0	;�����λ,��ֹ��λ��ֵ,Ӱ�����ս��
	adc dword ptr[ebx],0

	popad
	ret
Extended_Add ENDP
END main
