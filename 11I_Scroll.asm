;����Ļ����������ʾ50���ı�,Ȼ����ƿ���̨����λ�úʹ�С,�ﵽ��Ч��������Ч��
INCLUDE Irvine32.inc
.data
message BYTE ": This line of text was written"
	    BYTE "to the screen buffer",0dh,0ah
messageSize DWORD ($-message)
outHandle HANDLE 0						;��׼������
bytesWritten DWORD ?					;��д���ֽ���
lineNum		 DWORD 0
windowRect	SMALL_RECT <0,0,60,11>		;��������
.code
main PROC
	INVOKE GetStdHandle,STD_OUTPUT_HANDLE
	mov outHandle,eax
.REPEAT
	mov eax,lineNum
	call WriteDec
	INVOKE WriteConsole,			
		outHandle,				;����̨������
		ADDR message,			;�ַ���ָ��
		messageSize,			;�ַ�������
		ADDR bytesWritten,		;������д���ֽ���
		0						;δ��
	inc lineNum					;��һ�е��к�
.UNTIL lineNum>50

	INVOKE SetConsoleWindowInfo,
		outHandle,					;��Ļ������
		TRUE,						;��������,TRUE:����������̨�����µ����ϽǺ����½�λ��,FALSE��������ӵ���ǰ����̨������
		ADDR windowRect				;ָ�򴰿ھ��ε�����
	call ReadChar			;�ȴ�����
	call Clrscr				;�����Ļ������
	call ReadChar			;�ȴ��ڶ��ΰ���
	INVOKE ExitProcess,0

main ENDP
END main 
