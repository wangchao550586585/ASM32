TITLE Add and Subtract
.386		;cpu���Ҫ��intel386
.model flat,stdcall		;modelαָ��ָʾ�����Ϊ����ģʽ�������ɴ���,stdcall�������MS-Windows����
.stack 4096
ExitProcess PROTO,dwExitCode:DWORD		;2��PROTOαָ�������ó���ʹ�õĹ���ԭ��:
DumpRegs PROTO							;ExitProcess��һ��MS-Windows����,��ֹ��ǰ����(����);DumpRegs��Irvine32���ӿ�����ʾ�Ĵ����Ĺ���
.code
main2 PROC
	mov eax,10000h
	add eax,20000h
	sub eax,20000h
	call DumpRegs
	INVOKE ExitProcess,0	;����ExitProcess����ִ��,���ݸ��ú����Ĳ����Ƿ�����0,INVOKE��һ�����ù��̻����Ļ��αָ��
main2 ENDP
END main2