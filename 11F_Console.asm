;����̨���
INCLUDE Irvine32.inc
.data
endl EQU <0dh,0ah>
message LABEL BYTE
	BYTE "This program is a simple demonstration of "
	BYTE "console mode output, using the GetStdHandle "
	BYTE "and WriteConsole functions.", endl
messageSize DWORD ($-message)
consoleHandle HANDLE 0			;��׼����豸�ľ��
bytesWritten DWORD ?			;��������ַ�����
.code
main PROC
	INVOKE GetStdHandle,STD_OUTPUT_HANDLE
	mov consoleHandle,eax	  
	INVOKE WriteConsole		  ,	
	consoleHandle			  ,;����̨������
	ADDR message			  ,;�ַ���ָ��
	messageSize				  ,;�ַ�������
	ADDR bytesWritten		  ,;����ʵ��������ַ�����
	0						   ;δ��
	INVOKE ExitProcess,0
main ENDP
END main 