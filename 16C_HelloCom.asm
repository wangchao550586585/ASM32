;MASMҪ��com����ʹ��΢���ڴ�ģʽ,�ұ���ʹ��ORG�ѳ��������ʼ��ַ��Ϊ100h
;MS-DOS����COM����ʱ,����256�ֽ�PSP(�����ǰ׺)
;0-0100	0100-X		X-FFFE
;PSP		����		����-��ջ
;CS,DS,ES,SS����Ϊָ��PSP�Ļ���ַ
;�����ƫ��100h��ʼ,��ջ���ڶε���Ͷ�,SP=FFFEh
.model tiny
.code
org 100h			;�����main֮ǰ
main PROC
	mov ah,9
	mov dx,OFFSET hello_message
	int 21h
	mov ax,4C00h
	int 21h
main ENDP
;��Ϊû�е����Ķ����ڴ������,����ͨ���ѱ������������̺���
;��������ݷ��ڳ���ʼ,CPU�ͻ���ͼִ������,�����ٳ���ʼʹ��JMPָ������������,������һ��ʵ��ָ�ȥִ��
hello_message BYTE 'Hello, world!',0dh,ah,'$'
END main 