;��װCTRL-Break�м̴�������
INCLUDE Irvine16.inc
.data
breakMsg BYTE "BREAK",0
msg	BYTE "Ctrl-Break demonstration."
	BYTE  0dh,0ah
	BYTE "This program disables Ctrl-Break (Ctrl-C). Press any"
	BYTE  0dh,0ah
	BYTE "keys to continue, or press ESC to end the program."
	BYTE  0dh,0ah,0
.code
main PROC
	mov ax,@data
	mov ds,ax
	mov dx,OFFSET msg
	call WriteString

install_handler;
	push ds
	mov ax,@code
	mov ds,ax					
	mov ah,25h					;�������µ��м̴�����̵�ַ�滻ԭ�����жϴ������
	;�������ʱ���ػָ�INT23h�м�����,��ΪMS-DOS�ڳ������ʱ�Զ��ָ�int23h�ж�����,MS-DOS��ԭʼ��INT23h�洢�ڶ�ǰ׺ƫ��000Eh��
	mov al,23h					;������м�������
	mov dx,OFFSET break_handler	;DS:DX�µ�CTRL-BREAK�������Ķ�-ƫ�Ƶ�ַ
	int 21h						
	pop ds

	;�ȴ�����������
L1:	mov ah,1
	int 21h
	cmp al,18h
	jnz L1
	exit
main ENDP

;����ctrl-breakִ��
break_handler PROC
	push ax
	push dx
	mov dx,OFFSET breakMsg
	call WriteString
	pop dx
	pop ax
	iret
break_handler ENDP
END main 