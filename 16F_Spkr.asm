;������ͨ��61�˿ڿ����ر�
	;����:��ȡ61�˿�ֵ��Ͷ�λ��λ
	;�ر�:�����������
;Intel8253��ʱ������оƬ���Ʋ���������Ƶ��:��45�˿ڷ���0~255ֵ
INCLUDE Irvine16.inc
speaker EQU 61h				;�������˿ڵ�ַ
timer	EQU 42h				;��ʱ���˿ڵ�ַ
delay1	EQU 500
delay2	EQU 0D000h			;����֮�����ʱ
.code
main PROC	
	in al,speaker			;��ȡ������״̬
	push ax					;����״̬
	or al,00000011b			;�Ͷ�λ��λ
	out speaker,al			;��������
	mov al,60				;��ʼƵ��
L2:	out timer,al			;�������Ƶ�ʵ���ʱ���˿�
	;Ƶ�ʸı�ǰ����һ��ѭ��
	mov cx,delay1
L3:	push cx				;��ѭ��
	mov cx,delay2		;��ѭ��
L3a:
	loop L3a
	pop cx
	loop L3
	
	sub al,1			;���Ƶ��
	jnz L2				;������һ������
	
	pop ax				;��ȡ��ʼ״̬
	and al,11111100b	;������2λ
	out speaker,al		;�ر�������
	exit
main ENDP
END main 