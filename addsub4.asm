;16λʵ��ַģʽ
TITLE ADD and Subtract,Version 3
INCLUDE Irvine16.inc	

.data
val1 DWORD 10000h
val2 DWORD 40000h
val3 DWORD 20000h
finalVal DWORD ?

.code
main4 PROC
	mov ax,@data		;@data���ݶε���ʼ��ַ
	mov ds,ax

	mov eax,val1		;ʹ�õ���IA32������,��Ȼ����ʹ��32λ�Ĵ���
	add eax,val2
	sub eax,val3
	mov finalVal,eax
	call DumpRegs
	exit
main4 ENDP
END main4