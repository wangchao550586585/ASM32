;16λʵ��ַģʽ���
;ʹ��MS-DOS����Ļ�����HelloWorld
.MODEL small			;С���ڴ�ģʽ,�����ڵ����Ķ�,���ݺͶ�ջ������һ����
.STACK 100h				;���������512�ֽ�
.386					;����ʹ��32λ�Ĵ���
.data
message BYTE "Hello,world!",0dh,0ah
.code
main PROC
	;��ʼ��DS�Ĵ���ָ�����ݶε���ʼ��ַ
	mov ax,@data
	mov ds,ax

	mov ah,40h
	mov bx,1				;������,1��ʾ����̨
	mov cx,SIZEOF message
	mov dx,OFFSET message
	int 21h
	.EXIT
main ENDP
END main