;��ռ��̻����������ض��İ���,����Ϸ�������һЩ��û������İ���
;���µ��κμ����ᱻ���Բ��Ӽ��̻�����ɾ��,һֱ������ESCʱ������ֹ
INCLUDE Irvine16.inc
ClearKeyboard PROTO,scanCode:BYTE
ESC_key=1							;ɨ����
.code
main PROC
	L1:
		;���300ms����Ļ����ʾһ��Բ��
		mov ah,2
		mov dl,'.'
		int 21h
		mov eax,300						;��ʱ300ms
		call Delay
		INVOKE ClearKeyboard,ESC_KEY	;���ESC��
		jnz L1						;���ZF=0,�����ѭ��
	quit:
		call Clrscr
		exit
main ENDP

ClearKeyboard PROC,scanCode:BYTE
	push ax
L1:	mov ah,11h					;�����̻�����
	int 16h						;�����κ�һ������ô?
	jz noKey					;��:�˳�
	mov ah,10h					;��,�ӻ�����ɾ��
	int 16h		
	cmp ah,scanCode				;�Ƿ����˳�����?
	je quit						;��:�˳�,��ZF=1
	jmp L1						;��:�ڼ�黺����
noKey:							;�ް���
	or al,1						;������־
quit:
	pop ax
	ret
ClearKeyboard ENDP
END main 
