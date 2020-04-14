;�����ٳ���
;����X��Y�������������ƶ�����Ļ���½ǲ��ϸ���,�û��������ʱ,����λ����ʾ����Ļ�����½�
;INCLUDE Irvine16.inc
GET_MOUSE_STATUS=0
SHOW_MOUSE_POINTER=1
HIDE_MOUSE_POINTER=2
GET_CURSOR_SIZE=3
GET_BUTTON_PRESS_INFO=5
GET_MOUSE_POSITION_AND_STATUS=3
ESCkey=1Bh
.data
greeting BYTE "[Mouse.exe] Press Esc to quit",0
statusLine BYTE "Left button: "
		   BYTE "Mouse position: ",0
blanks	   BYTE "                ",0
xCoord WORD 0							;��ǰX����
yCoord WORD 0
xPress WORD 0							;��󰴰�ťX����
yPress WORD 0

;��ʾ����
statusRow	BYTE ?
statusCol	BYTE 15
buttonPressCol BYTE 20
statusCol2	BYTE 60
coordCol	BYTE 65

.code 
main PROC
	mov ax,@data
	mov ds,ax
	call Clrscr

	;��ȡ��ĻXY����
	call GetMaxXY				;DH=rows,DL=columns
	dec dh						;����״̬��ֵ
	mov statusRow,dh		

	;�����ı����,��ʾ���
	call HideCursor
	mov dx,OFFSET greeting
	call WriteString
	call ShowMousePointer

	;�ڰ�ť��Ļ����ʾ״̬��Ϣ
	mov dh,statusRow			;gotoxy����ƶ���ָ��λ��
	mov dl,0
	call Gotoxy				
	mov dx,OFFSET statusLine
	call WriteString

	;ѭ����ʾ���λ��,����Ƿ���������
	;���°�ť��ESC key
L1:	call ShowMousePosition
	call LeftButtonPress			;����Ƿ���������
	mov ah,11h						;�Ƿ��������?
	int 16h
	jz L2							;û��,����ѭ��
	mov ah,10h						;��������ɾ����
	int 16h
	cmp al,ESCkey					;�����Ƿ���ESC
	je quit							;��:�˳�
L2: jmp L1

quit:
	call HideMousePointer
	call ShowCursor
	call Clrscr
	call WaitMsg
	exit
main ENDP

HideCursor PROC USES ax cx
	mov ah,GET_CURSOR_SIZE
	int 10h
	or ch,30h			;��������СΪ�Ƿ�ֵ,������������Ч��
	mov ah,1			
	int 10h
	ret
HideCursor ENDP

ShowMousePointer PROC USES ax
	mov ax,SHOW_MOUSE_POINTER		;��ʾ���ָ��
	int 33h
	ret
ShowMousePointer ENDP

ShowMousePosition PROC
	pusha
	
	;�������û�иı�,�˳�����
	call GetMousePosition
	cmp cx,xCoord					;
	jne L1
	cmp dx,yCoord
	je L2

	;�����µ�XY����
L1:	mov xCoord,cx
	mov yCoord,dx

	;���½��������
	mov dh,statusRow
	mov dl,statusCol2
	call Gotoxy
	push dx
	mov dx,OFFSET blanks
	call WriteString
	pop dx

	;���½���ʾ���XY����
	call Gotoxy
	mov ax,xCoord
	call WriteDec
	mov dl,coordCol
	call Gotoxy
	mov ax,yCoord
	call WriteDec

L2:	popa
	ret
ShowMousePosition ENDP

LeftButtonPress PROC
	pusha
	
	mov ax,GET_BUTTON_PRESS_INFO
	mov bx,0
	int 33h

	;�������û�иı����˳�
	cmp cx,xPress
	jne L1
	cmp dx,yPress
	je L2

L1: mov xPress,cx
	mov yPress,dx
	

	;���½��������
	mov dh,statusRow
	mov dl,statusCol
	call Gotoxy
	push dx
	mov dx,OFFSET blanks
	call WriteString
	pop dx


	;���½���ʾ���XY����
	call Gotoxy
	mov ax,xCoord
	call WriteDec
	mov dl,buttonPressCol
	call Gotoxy
	mov ax,yCoord
	call WriteDec

L2: popa
	ret
LeftButtonPress ENDP


HideMousePointer PROC
	mov ax,HIDE_MOUSE_POINTER
	int 33h
	ret
HideMousePointer ENDP

ShowCursor PROC USES ax cx
	mov ah,GET_CURSOR_SIZE
	int 10h
	mov ah,1
	mov cx,0607h
	int 10h
	ret
ShowCursor ENDP

GetMousePosition PROC USES ax
	mov ax,GET_MOUSE_POSITION_AND_STATUS
	int 33h
	ret
GetMousePosition ENDP

END main 

