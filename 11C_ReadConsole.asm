INCLUDE Irvine32.inc
BufSize=80
.data
buffer BYTE BufSize DUP(?),0,0
stdInHandle HANDLE ?
bytesRead   DWORD ?
.code
main PROC
	INVOKE GetStdHandle,STD_INPUT_HANDLE
	mov stdInHandle,eax
	;������,��������ַָ��,��ȡ�ַ�����,����ʵ��������С��ָ��(��ȡ����������س��ͻ���2��������ַ�),����
	INVOKE ReadConsole,stdInHandle,ADDR buffer,BufSize-2,ADDR bytesRead,0

	mov esi,OFFSET buffer
	mov ecx,bytesRead
	mov ebx,TYPE buffer
	call DumpMem
	exit
main ENDP
END main 
