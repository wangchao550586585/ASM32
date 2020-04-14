;�ѿ����������
INCLUDE Irvine16.inc

Mode_6A=6Ah					;800*600,16ɫ
X_axisY=300
X_axisX=50
X_axisLen=700

Y_axisY=400
Y_axisY=30
Y_axisY=540

.data
saveMode BYTE ?
.code
main PROC
	mov ax,@data
	mov ds,ax

	;���浱ǰ��Ƶģʽ
	mov ah,0Fh
	int 10h
	mov saveMode,al

	;�л���ͼ��ģʽ
	mov ah,0
	mov al,Mode_6A		;800*600,16ɫ
	int 10h

	;����X��
	mov cx,X_axisX		;������ʼX����
	mov dx,X_axisY		;������ʼY����
	mov ax,X_axisLen	;��������
	mov bl,white		;������ɫ
	call DrawHorizLine	;��������

	;����Y��
	mov cx,Y_axisX		
	mov dx,Y_axisY
	mov ax,Y_axisLen
	mov bl,white
	call DrawVerticalLine

	;�ȴ�����
	mov ah,10h
	int 16h

	;�ָ���ʼ����Ƶģʽ
	mov ah,0
	mov al,saveMode
	int 10h
	
	exit
main ENDP

DrawHorizLine PROC
	.data
	currX WORD ?
	.code
		pusha
		mov currX,cx
		mov cx,ax
	DHL1:
		push cx
		mov al,bl			;��ɫ
		mov ah,0Ch			;д����
		mov bh,0			;��Ƶҳ0
		mov cx,currX		;CX=x����,DX:y����
		int 10h
		inc currX
		pop cx
		Loop DHL1
		popa
		ret
DrawHorizLine ENDP

DrawVerticalLine PROC
	.data
	currY WORD ?
	currX WORD ?
	.code
		pusha
		mov currY,dx
		mov currX,cx
		mov cx,ax
	DHL1:
		push cx
		mov al,bl			;��ɫ
		mov ah,0Ch			;д����
		mov bh,0			;��Ƶҳ0
		mov dx,currY		;CX=x����,DX:y����
		mov cx,currX
		int 10h
		inc currY
		pop cx
		Loop DHL1
		popa
		ret
DrawVerticalLine ENDP
END main 
