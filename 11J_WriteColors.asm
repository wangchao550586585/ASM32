;ʹ����ɫ����
INCLUDE Irvine32.inc
.data
outHandle		HANDLE  ?
cellsWritten	DWORD   ?	
xyPos			COORD	<10,20>
buffer BYTE 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
	   BYTE 16,17,18,19,20
BufSize DWORD ($-buffer)
attributes WORD 0Fh,0Eh,0Dh,0Ch,0Bh,0Ah,9,8,7,6
		   WORD 5,4,3,2,1,0F0h,0E0h,0D0h,0C0h,0B0h
.code
main PROC
	;��ȡ����̨��׼������
	INVOKE GetStdHandle,STD_OUTPUT_HANDLE
	mov outHandle,eax

	;�������������ַ������ɫ
	INVOKE WriteConsoleOutputAttribute,
			outHandle,					;������
			ADDR attributes,			;��ɫ��������,ÿ��������ֽڴ����ɫֵ
			BufSize,					;�������
			xyPos,						;��Ļ�н�����Щ���Ե��ַ������ʼ����
			ADDR cellsWritten			;��дʵ�ʱ�������ɫ���Ե��ַ�������

	;���1-20���ַ�
	INVOKE WriteConsoleOutputCharacter,
			outHandle,ADDR buffer,BufSize,
			xyPos,ADDR cellsWritten
	INVOKE ExitProcess,0
main ENDP
END main 