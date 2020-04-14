.model large		;使用大型内存模式编译,允许段超过64K,要求数据指针和返回值使用32位
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