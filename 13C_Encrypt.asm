;�ӱ�׼�����϶�ȡÿ���ַ�,ʹ��XORָ��ı��ַ�,���Ѹı���ַ������׼���
;�ض���������ζ�����������ı����Ǽ���
;Encrypt < infile.text >outfile.text �������ļ����������ļ�
INCLUDE Irvine16.inc
XORVAL=239
.code
main PROC
	mov ax,@data
	mov ds,ax
L1:
	mov ah,6		;ֱ�ӿ���̨����
	mov dl,0FFh		;���ȴ��ַ�
	int 21h			;al=�ַ�
	jz L2			;ZF=1���˳�
	xor al,XORVAL
	mov ah,6		;д���׼���
	mov dl,al
	int 21h
	jmp L1
L2:	exit
main ENDP
END main