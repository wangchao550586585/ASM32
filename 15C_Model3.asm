;�ڴ�ӳ��ͼ�γ���
;��Ƶģʽ13h,����Ļ����ӳ��Ϊһ����ά�ֽ�����,ÿ�����ص���ռ��1�ֽ�(�ܹ���256����ɫ,ÿ���ֽ�ָʾһ�ֲ�ͬ��ɫ).
;�������Ļ���Ͻǿ�ʼ,���½ǽ���
;ʹ��13hʹ��ֱ���ڴ�ӳ��ķ�������Ļ�ϻ��ư���10�����ص���
INCLUDE Irvine16.inc

VIDEO_PALLETE_PORT=3C8h			;��Ƶɫ�ʵ�ɫ��
COLOR_SELECTION_PORT=3C9h
COLOR_INDEX=1
PALLETE_INDEX_BACKGROUND=0
SET_VIDEO_MODE=0
GET_VIDEO_MODE=0Fh
VIDEO_SEGMENT=0A000h
WAIT_FOR_KEYSTROKE=10h
MODE_13=13h
.data
saveMode BYTE ?
xVal WORD ?							;X����
yVal WORD ?							;Y����
msg BYTE "Welcome to Mode 13!",0
.code
main PROC
	mov  ax,@data
	mov ds,ax

	call SetVideoMode
	call SetScreenBackground

	mov edx,OFFSET msg
	call WriteString

	call Draw_Some_Pixels
	call RestoreVideoMode
	exit
main ENDP

SetVideoMode PROC
	mov ah,GET_VIDEO_MODE
	int 10h
	mov saveMode,al

	mov ah,SET_VIDEO_MODE
	mov al,MODE_13					;����ģʽ13h
	int 10h
		
	push VIDEO_SEGMENT				;��Ƶ�ε�ַ���浽ES
	pop es							
	ret
SetVideoMode ENDP

SetScreenBackground PROC
	mov dx,VIDEO_PALLETE_PORT			;��ʾҪ�޸ĵĵ�ɫ�����
	mov al,PALLETE_INDEX_BACKGROUND		;���ֵ
	out dx,al							;������غ���ɫֵ����Ƶ�������˿�

	;��Ļ��������Ϊ����
	mov dx,COLOR_SELECTION_PORT			;Ҫ�޸�Ϊ����ɫֵ
	mov al,0				;��
	out dx,al
	mov al,0				;��
	out dx,al
	mov al,35				;��(����35/63)
	out dx,al
	ret
SetScreenBackground ENDP


Draw_Some_Pixels PROC
	;����1����ɫ��Ϊ��ɫ
	mov dx,VIDEO_PALLETE_PORT
	mov al,1				;���õ�ɫ������1
	out dx,al

	mov dx,COLOR_SELECTION_PORT
	mov al,63				;��
	out dx,al	
	mov al,63				;��
	out dx,al		
	mov al,63				;��
	out dx,al

	;�����һ�����ص���Ƶ������ƫ�Ƶ�ַ,(���ĵ�)
	;�ֱ�����320*200,���ĵ���160*100
	mov xVal,160
	mov yVal,100
	mov ax,320
	mul yVal
	add ax,xVal				;ax�������ĵ��ƫ��

	mov cx,10				;����10������
	mov di,ax
DP1:
	mov BYTE PTR es:[di],COLOR_INDEX
	add di,5				;����5����
	loop DP1
	ret
Draw_Some_Pixels ENDP

RestoreVideoMode PROC
	mov ah,WAIT_FOR_KEYSTROKE
	int 16h
	mov ah,SET_VIDEO_MODE
	mov al,saveMode
	int 10h
	ret
RestoreVideoMode ENDP

END main 