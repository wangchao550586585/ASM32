;�Ͼ���
INCLUDE Irvine16.inc
.data
message BYTE "Message in Window",0
.code
main PROC
	mov ax,@data
	mov ds,ax
	
	mov ax,0600h				;��������,ah�Ͼ���,al�Ͼ�����(0ȫ��)
	mov bh,(blue SHL 4)OR yellow;�հ��������Ƶ����,��������
	mov cx,050Ah				;���Ͻ�,����λ��
	mov dx,0A30h				;���Ͻ�,����λ��
	int 10h

	mov ah,2					;���ù��λ��
	mov dx,0714h				;��7��20
	mov bh,0					;��Ƶҳ0
	int 10h

	mov dx,OFFSET message
	call WriteString

	mov ah,10h
	int 16h
	exit
main ENDP
END main 