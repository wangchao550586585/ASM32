;��д��Ч����������ֵ�Ļ�����
.586
.model flat,C				;ָ��C����Լ��,����Ϊ�ⲿC++������õ�ÿ����������ԭ��PROTO,C������ʹ��extern�ؼ��������ⲿ�������
AsmFindArray PROTO,
	srchVal:DWORD,arrayPtr:PTR DWORD,count:DWORD
	.code

AsmFindArray PROC USES edi,
	srchVal:DWORD,arrayPtr:PTR DWORD,count:DWORD
	true=1
	false=0
	mov eax,srchVal
	mov ecx,count
	mov edi,arrayPtr
	repne scasd		;����
	jz returnTrue	;����ҵ�ZF=1
returnFalse:
	mov al,false
	jmp short exit
returnTrue:
	mov al,true
exit:
	ret
AsmFindArray ENDP
END