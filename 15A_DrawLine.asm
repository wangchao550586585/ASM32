;ʹ��int10h�л���ͼ��ģʽ�»���һ��ˮƽֱ��
INCLUDE Irvine16.inc

;--------------------��Ƶģʽ����
Mode_06=6	;640*200,2 colors
Mode_0D=0Dh	;320*200,16 colors
Mode_0E=0Eh	;640*200,16 colors
Mode_0F=0Fh	;640*350,2 colors
Mode_10=10h	;640*350,16 colors
Mode_11=11h	;640*480,2 colors
Mode_12=12h	;640*480,16 colors
Mode_13=13h	;640*200,256 colors
Mode_6A=6Ah	;640*600,16 colors

.data
saveMode BYTE ?			;���浱ǰ��Ƶģʽ
currentX WORD 100		;�к�X����
currentY WORD 100		;�к�Y����
COLOR=1001b				;����ɫ(��)

progTitle BYTE "DrawLine.asm"
TITLE_ROW=5
TITLE_COLUMN=14

;ʹ��˫ɫģʽʱ,COLOR��Ϊ1(��ɫ)
.code
main PROC
	mov ax,@data
	mov ds,ax
	;���浱ǰ��Ƶģʽ
	mov ah,0Fh
	int 10h
	mov saveMode,al

	;�ĳ�ͼ��ģʽ
	mov ah,0
	mov al,Mode_6A
	int 10h

	;���ı���ʽд������
	mov ax,SEG progTitle				;��ȡprogTitle��
	mov es,ax							;����es��
	mov bp,OFFSET progTitle				
	mvo ah,13h							;����:д�ַ���
	mov al,0							;ģʽ:ֻ���ַ�����
	mov bh,0							;��Ƶҳ��:0
	mov bl,7							;����:normal
	mov cx,SIZEOF progTitle				;�ַ�������
	mov dh,TITLE_ROW					;��,�ַ���
	mov dl,TITLE_COLUMN					;��,�ַ���
	int 10h

	;��һ��ֱ��
	LineLength=100
	mov dx,currentY
	mov cx,LineLength

L1:	push cx
	mov ah,0Ch							;д����
	mov al,COLOR						;������ɫ,����ֵ
	mov bh,0							;��Ƶҳ0
	mov cx,currentX						;CX=x����,DX:y����
	int 10h
	inc currrentX
	;inc color							;���ò鿴����ɫ�еĹ���
	pop cx
	Loop L1

	;�ȴ�����
	mov ah,0
	int 16h

	;�ָ���ʼ����Ƶģʽ
	mov ah,0
	mov al,saveMode						;���Ը���ΪMode_xx
	int 10h
	exit
main ENDP
END main 

