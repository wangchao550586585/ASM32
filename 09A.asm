cld				
mov esi,OFFSET string1
mov edi,OFFSET string2
mov ecx,10
rep movsb

------比较双字
.data
source DWORD 1234h
target DWORD 5678h
.code
	mov esi,OFFSET source
	mov edi,OFFSET target
	cmpsd		;比较双字
	ja L1		;source>target则跳转
	jmp L2

------比较多个双字
	mov esi,OFFSET source
	mov edi,OFFSET target
	cld						;需要设置清除方向标志,向前
	mov ecx,count
	repe cmpsd		;REPE前缀重复进行比较动作,自动增加ESI/EDI,直到ECX=0或发现任何一对双字不相等为止


------scasb查找单个字
.data
alpha BYTE "ABCDEFGH",0
.code
mov edi,OFFSET alpha
mov al,'F'
mov ecx,LENGTHOF alpha
cld
repne scasb		
jnz quit		;字符未找到则退出
dec edi			;找到了EDI回退

---------------stosb,string1每个字节初始化0FFh
.data
Count=100
string BYTE Count DUP(?)
.code
mov al,0FFh
mov edi,OFFSET string1
mov ecx,Count
cld
rep stosb

-------------计算一行之和
基址变址操作数
calc_row_sum PROC uses ebx ecx edx esi
	mul ecx		;rowIndex*rowSize
	add ebx,eax	;行偏移地址
	mov eax,0
	mov esi,0	;列地址

L1:	movzx edx,BYTE PTR[ebx+esi]
	add eax,edx
	inc esi
	loop L1
	ret
calc_row_sum ENDP


