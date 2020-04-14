;¼ÆËã3ÊýºÍ
INCLUDE Irvine32.inc
.data
theSum DWORD ?
.code
main PROC
	mov eax,10000h
	mov ebx,20000h
	mov ecx,30000h
	call SumOf		;EAX=EAX+EBX+ECX
	mov theSum,eax
main ENDP

SumOf PROC
	add eax,ebx
	add eax,ecx
	ret
SumOf ENDP

END main