;�ж������εĳ���
.model small,stdcall				;��С�ڴ�ģʽ��,.CODEαָ��ʹ���������һ����Ϊ_TEXT�Ķ�
.stack 100h							;���д����ģʽ�еĳ���,ÿ��Դ����ģ��(�ļ���)�������費ͬ������,��ʽ:ģ����_TEXT
WriteString PROTO
.data
msg1 db "First Message",0dh,0ah,0
msg2 db "Second Message",0dh,0ah,"$"
.code						;_TEXT�ΰ���main����
main PROC
	mov ax,@data
	mov dx,ax

	mov dx,OFFSET msg1
	call WriteString		;������,���ñ���16λ���ӿ�������,��Щ����ֻ������Ϊ_TEXT�Ķ���
	call Display			;Զ����,
	.exit					
main ENDP

;�����ڴ�ģʽ���,��������ͬһ��ģ����������������,codeαָ�����ӿ�ѡ�Ķ���
.code OtherCode				;otherCode�ΰ���Display����,Display������һ��FAR���η�,��ʾ֪ͨ���������Զ����(FAR)ָ��
							;Զ���û��ڶ�ջ�ϱ���ε�ַ��ƫ�Ƶ�ַ
Display PROC FAR
	mov ah,9
	mov dx,offset msg2
	int 21h
	ret
Display ENDP
END main 