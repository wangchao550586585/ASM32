;��ʾ��ɫ�ַ���
INCLUDE Irvine16.inc
.data
ATTRIB_HI=10000000b
string BYTE "ABCDEFGHIJKLMOP"
color  BYTE	(black SHL 4) OR blue
.code
main PROC
	mov ax,@data
	mov ds,ax

	call Clrscr
	call EnableBliking			;��ѡ
	mov cx,SIZEOF string
	mov si,OFFSET string

L1:	push cx
	mov ah,9					;��ʾ�ַ�/����
	mov al,[si]					;��ʾ�ַ�
	mov bh,0					;��Ƶҳ0
	mov bl,color				;����
	or bl,ATTRIB_HI				;������˸/����λ
	mov cx,1					;��ʾһ��
	int 10h
	mov cx,1					;ǰ�������
	call AdvanceCursor			;��Ļ�ϵ���һ��
	inc color					;��һ����ɫ
	inc si						;��һ���ַ�
	pop cx						
	loop L1
	call Crlf
	exit
main ENDP

EnableBliking PROC
	push ax
	push bx
	mov ax,1003h		;�л���˸/����
	mov bl,1			;������˸
	int 10h
	pop bx
	pop ax
	ret
EnableBliking ENDP

AdvanceCursor PROC
	pusha

L1:	push cx
	mov ah,3				;��ȡ���λ��
	mov bh,0				;��Ƶҳ0
	int 10h					;�ı�cx�Ĵ���(�����ʼ,����ɨ����),λ��ֵ��DH,DL��
	inc	dl					;������
	mov ah,2				;���ù��λ��
	int 10h
	pop cx
	loop L1

	popa
	ret
AdvanceCursor ENDP
END main 