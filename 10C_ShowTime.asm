;��ȡ��ǰϵͳʱ�䲢��ָ����Ļλ������ʾ,ֻ���ڱ���ģʽִ��
INCLUDE Irvine32.inc
.data
sysTime SYSTEMTIME <>
XYPos COORD <10,5>
consoleHandle DWORD ?
colonStr BYTE ":",0
.code
main PROC
	;��ȡwin32����̨�ı�׼������
	INVOKE GetStdHandle,STD_OUTPUT_HANDLE
	mov consoleHandle,eax

	;���ù��λ�ò���ȡϵͳʱ��
	INVOKE SetConsoleCursorPosition,consoleHandle,XYPos
	INVOKE GetLocalTime,ADDR sysTime

	;��ʾϵͳʱ��
	movzx	eax,sysTime.wHour			;ʱ
	call	WriteDec
	mov		edx,OFFSET colonStr			;":"
	call	WriteString
	movzx	eax,sysTime.wMinute			;��
	call	WriteDec
	call	WriteString
	movzx	eax,sysTime.wSecond			;��
	call	WriteDec
	call	Crlf
	call	WaitMsg
	exit
main ENDP

END main
