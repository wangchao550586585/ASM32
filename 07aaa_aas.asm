mov ah,0
mov al,'8'
add al,'2'	;ax���2��ASCIIʮ����������ӵĺ�	
aaa			;aaa��AX�еĺ�ת����2��δѹ����ʮ������
or ax,3030h	;or30ת������ӦASCII����

.data
val1 BYTE '8'
val2 BYTE '9'
.code 
mov ah,0
mov al,val1
sub al,val2
aas			
pushf
	or al,30h	
popf

.data
AscVal BYTE 05h,06h
.code
mov bl,ascVal
mov al,ascVal+1
mul bl			;����ʹ��δѹ����10������
aam				;�ѳ˻��Ķ�����ת����δѹ��ʮ����

.data
.code
	mov ax,0307h
	aad			;����֮ǰ,��Ҫִ��aad����AX��δѹ��ʮ���Ʊ�����
	mov bl,5
	div bl		

