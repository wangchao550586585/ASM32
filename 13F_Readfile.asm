;��ȡ�������ı��ļ�
.data
BufSize=5000
infile BYTE "my_text_file.text",0
outfile BYTE "my_output_file.text",0
inHandle WORD ?
outHandle WORD ?
buffer BYTE BufSize DUP(?)
bytesRead WORD ?
.code
main PROC
	mov ax,@data
	mov ds,ax

	;�������ļ�
	mov ax,716Ch		;��չ�Ĵ������
	mov bx,0			;ģʽ=ֻ��
	mov cx,0			;��ͨ����
	mov dx,1			;����:��
	mov si,OFFSET infile
	int 21h
	jc quit				;�����������˳�
	mov inHandle,ax

	;��ȡ�����ļ�
	mov ah,3Fh			;��ȡ�ļ����豸
	mov bx,inHandle		;�ļ����
	mov cx,BufSize		;����ȡ�ֽ���
	mov dx,OFFSET buffer	;������ָ��
	int 21h	
	jc quit
	mov bytesRead,ax

	;��ʾ������
	mov ah,40h		;д�ļ����豸
	mov bx,1		;����̨������
	mov cx,bytesRead	;�ֽ���
	mov dx,OFFSET buffer	;������ָ��
	int 21h
	jc quit

	;�ر��ļ�
	mov ah,3Eh		;�ر��ļ�
	mov bx,inHandle	;�����ļ����
	int 21h
	jc quit

	;��������ļ�
	mov ax,716Ch	;��չ�Ĵ������
	mov bx,1		;ģʽ=ֻд
	mov cx,0		;��ͨ����
	mov dx,12h		;����:����/����
	mov si,OFFSET outfile
	int 21h
	jc quit
	mov outHandle,ax

	;������д��һ�����ļ�
	mov ah,40h			;д�ļ����豸
	mov bx,outHandle	;����ļ����
	mov cx,bytesRead	;�ֽ���
	mov dx,OFFSET buffer	;������ָ��
	int 21h
	jc quit
	
	;�ر��ļ�
	mov ah,3Eh		;�ر��ļ�
	mov bx,outHandle	;����ļ����
	int 21h

quit:
	call Crlf
	exit
main ENDP
END main 