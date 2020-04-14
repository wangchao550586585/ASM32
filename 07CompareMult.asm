;比较MUL/IMUL和移位指令性能
INCLUDE Irvine32.inc
LOOP_COUNT = 0FFFFFFFFh
.data
intval DWORD 5
startTime DWORD ?
.code
main PROC
	call GetMseconds
	mov startTime,eax
	mov eax,intVal
	call mult_by_shifting
	call GetMseconds	
	sub eax,startTime
	call WriteDec

	call	Crlf

; Second approach:

	call	GetMseconds	; get start time
	mov	startTime,eax
	
	mov	eax,intval
	call	mult_by_MUL

	call	GetMseconds	; get stop time
	sub	eax,startTime
	call	WriteDec		; display elapsed time
	call	Crlf

	exit
main ENDP

mult_by_shifting PROC
	mov ecx,LOOP_COUNT

 L1:push eax
	mov ebx,eax
	shl eax,5
	shl ebx,2
	add eax,ebx
	pop eax
	loop L1

	ret

mult_by_shifting ENDP

mult_by_MUL PROC
	mov ecx,LOOP_COUNT
 L1:push eax
	mov ebx,36
	mul ebx
	pop eax
	loop L1
	ret
mult_by_MUL ENDP

END main