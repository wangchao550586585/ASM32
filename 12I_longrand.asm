.model large		;ʹ�ô����ڴ�ģʽ����,����γ���64K,Ҫ������ָ��ͷ���ֵʹ��32λ
.386
Public _LongRandom
.data
seed DWORD 12345678h
.code
_LongRandom PROC far,C
	mov eax,343FDh
	mul seed
	xor edx,edx
	add eax,269EC3h
	mov seed,eax
	ror eax,8
	shld edx,eax,16
	ret
_LongRandom ENDP
END