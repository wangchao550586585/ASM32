;多双字移位
;3个双字组成的数值,右移一位
.data
ArraySize=3
array DWORD ArraySize DUP(99999999h)
.code
mov esi,0
shr array[esi+8],1		;最高位置处的双字右移一位,最低位复制到进位标志中
rcr array[esi+4],1		;ESI+4处的值右移一位,最高位自动以进位标志的值填充,最低位复制到进位标志中
rcr array[esi],1

;二进制乘法
EAX*36=EAX*2^5+EAX*2^2
.code
mov eax,123
mov ebx,eax
shl eax,5
shl ebx,2
add eax,ebx

;二进制整数转换成ASCII二进制字符串
BinToAsc PROC
	push ecx
	push esi
	
	mov ecx,32		;eax中数据位的数目
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

;分离MS-DOS文件的各个日期域
DX:0~4日,5~8月,9~15年
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