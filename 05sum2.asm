;计算3数和,使用USES
INCLUDE Irvine32.inc
.data
	array DWORD 10000h,20000h,30000h,40000h,50000h
	theSum DWORD ?
.code
main PROC
	mov esi,OFFSET array
	mov ecx,LENGTHOF array
	call ArraySum
	mov theSum,eax
main ENDP
;---------------------
ArraySum PROC
;
;计算32位数组和
;Receives: ESI=数组偏移
;		   ECX=数组个数
;Returns:  EAX=数组总和
;---------------------
	push esi
	push ecx
	mov eax,0
    
 L1:add eax,[esi]			;eax存储结果
	add esi,TYPE DWORD		;指向下一个整数
	loop L1

	pop ecx
	pop esi
	ret
ArraySum ENDP


ArraySum2 PROC USES esi ecx
	mov eax,0
    
 L1:add eax,[esi]			
	add esi,TYPE DWORD		
	loop L1

	ret
ArraySum2 ENDP

END main