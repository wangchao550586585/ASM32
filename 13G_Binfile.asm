;������������һ������,����Ļ��ʾ
;����д��2�����ļ�,�ر��ļ�
;���´��ļ�,��ȡ������Ļ��ʾ
INCLUDE Irvine16.inc
.data
myArray		DWORD 50 DUP (?)
fileName	BYTE "binary array file.bin",0
fileHandle	WORD ?
commaStr	BYTE ", ",0
CreateFile=1
.code
main PROC
	mov ax,@data
	mov ds,ax

	.IF CreateFile EQ 1
		call FillTheArray			
		call DisplayTheArray
		call CreateTheFile
		call WaitMsg
		call Crlf
	.ENDIF
		call ReadTheFile
		call DisplayTheArray
	quit:
		call Crlf
	exit
main ENDP

FillTheArray PROC
	mov cx,LENGTHOF myArray
	mov si,0
L1:	mov eax,1000
	call RandomRange		;���������0~999

	mov myArray[si],eax
	add si,TYPE myArray
	loop L1
	ret
FillTheArray ENDP

DisplayTheArray PROC
	mov cx,LENGTHOF myArray
	mov si,0
L1: mov eax,myArray[si]
	call WriteHex
	mov edx,0FFSET commaStr
	call WriteString
	add si,TYPE myArray
	loop L1
	ret
DisplayTheArray ENDP

CreateTheFile PROC
	mov ax,716Ch				;�����ļ�
	mov bx,1					;ģʽ,ֻд
	mov cx,0					;��ͨ�ļ�
	mov dx,12h					;����:����/����
	mov si,OFFSET fileName		;�ļ���
	int 21h						
	jc quit						;�������˳�
	mov fileHandle,ax			;������
	
	;���ļ�д����������
	mov ah,40h					;д�ļ����豸
	mov bx,fileHandle
	mov cx,SIZEOF myArray
	mov dx,OFFSET myArray
	int 21h

	jc quit

	;�ر��ļ�
	mov ah,3Eh
	mov bx,fileHandle
	int 21h
quit:
	ret
CreateTheFile ENDP

ReadTheFile PROC
	;���ļ�,��ȡ���
	mov ax,716Ch					
	mov bx,0				;ģʽ:ֻ��
	mov cx,0				;����:��ͨ
	mov dx,1				;���Ѵ��ڵ��ļ�
	mov si,OFFSET fileName
	int 21h
	jc quit
	mov fileHandle,ax

	;��ȡ�����ļ�,Ȼ��ر��ļ�
	mov ah,3Fh					;���ļ����豸
	mov bx,fileHandle			
	mov cx,SIZEOF myArray
	mov dx,OFFSET myArray
	int 21h

	jc quit
	mov ah,3Eh					;�ر��ļ�
	mov bx,fileHandle
	int 21h
quit:
	ret
ReadTheFile ENDP

END main 