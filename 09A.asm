cld				
mov esi,OFFSET string1
mov edi,OFFSET string2
mov ecx,10
rep movsb

------�Ƚ�˫��
.data
source DWORD 1234h
target DWORD 5678h
.code
	mov esi,OFFSET source
	mov edi,OFFSET target
	cmpsd		;�Ƚ�˫��
	ja L1		;source>target����ת
	jmp L2

------�Ƚ϶��˫��
	mov esi,OFFSET source
	mov edi,OFFSET target
	cld						;��Ҫ������������־,��ǰ
	mov ecx,count
	repe cmpsd		;REPEǰ׺�ظ����бȽ϶���,�Զ�����ESI/EDI,ֱ��ECX=0�����κ�һ��˫�ֲ����Ϊֹ


------scasb���ҵ�����
.data
alpha BYTE "ABCDEFGH",0
.code
mov edi,OFFSET alpha
mov al,'F'
mov ecx,LENGTHOF alpha
cld
repne scasb		
jnz quit		;�ַ�δ�ҵ����˳�
dec edi			;�ҵ���EDI����

---------------stosb,string1ÿ���ֽڳ�ʼ��0FFh
.data
Count=100
string BYTE Count DUP(?)
.code
mov al,0FFh
mov edi,OFFSET string1
mov ecx,Count
cld
rep stosb

-------------����һ��֮��
��ַ��ַ������
calc_row_sum PROC uses ebx ecx edx esi
	mul ecx		;rowIndex*rowSize
	add ebx,eax	;��ƫ�Ƶ�ַ
	mov eax,0
	mov esi,0	;�е�ַ

L1:	movzx edx,BYTE PTR[ebx+esi]
	add eax,edx
	inc esi
	loop L1
	ret
calc_row_sum ENDP


