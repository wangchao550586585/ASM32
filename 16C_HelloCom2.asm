.model tiny
.code
org 100h			;�����main֮ǰ
main PROC
;��Ϊû�е����Ķ����ڴ������,����ͨ���ѱ������������̺���
;��������ݷ��ڳ���ʼ,CPU�ͻ���ͼִ������,�����ٳ���ʼʹ��JMPָ������������,������һ��ʵ��ָ�ȥִ��
	jmp start
	hello_message BYTE 'Hello, world!',0dh,ah,'$'
start:
	mov ah,9
	mov dx,OFFSET hello_message
	int 21h
	mov ax,4C00h
	int 21h
main ENDP
END main 