;��˫����λ
;3��˫����ɵ���ֵ,����һλ
.data
ArraySize=3
array DWORD ArraySize DUP(99999999h)
.code
mov esi,0
shr array[esi+8],1		;���λ�ô���˫������һλ,���λ���Ƶ���λ��־��
rcr array[esi+4],1		;ESI+4����ֵ����һλ,���λ�Զ��Խ�λ��־��ֵ���,���λ���Ƶ���λ��־��
rcr array[esi],1

;�����Ƴ˷�
EAX*36=EAX*2^5+EAX*2^2
.code
mov eax,123
mov ebx,eax
shl eax,5
shl ebx,2
add eax,ebx

;����������ת����ASCII�������ַ���
BinToAsc PROC
	push ecx
	push esi
	
	mov ecx,32		;eax������λ����Ŀ
	L1:shl eax,1
	mov BYTE PTR[esi],'0'
	jnc L2
	mov BYTE PTR[esi],'1'

	L2:inc esi
	loop L1

	pop ecx
	pop esi
	ret
BinToAsc ENDP

;����MS-DOS�ļ��ĸ���������
DX:0~4��,5~8��,9~15��
mov al,dl
and al,00011111b
mov day,al

mov ax,dx
shr ax,5
and al,00001111b
mvo mounth,al

mov al,dh
shr al,1
mov ah,0
add ax,1980
mov year,ax