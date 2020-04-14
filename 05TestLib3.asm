;计算执行嵌套循环所需时间
INCLUDE Irvine32.inc
OUTER_LOOP_COUNT=1	;该值根据处理器的速度进行调整
.data
startTime DWORD ?
msg1 BYTE "Please wait...",0dh,0ah,0
msg2 BYTE "Elapsed milliseconds: ",0

.code
main PROC
	mov edx,OFFSET msg1
	call WriteString

	call GetMSeconds
	mov startTime,eax
	mov ecx,OUTER_LOOP_COUNT

 L1:call innerLoop
	loop L1

	call GetMSeconds
	sub eax,startTime
	mov edx,OFFSET msg2
	call WriteString
	call WriteDec
	call Crlf
	exit
main ENDP

innerLoop PROC
	push ecx
	mov ecx,0FFFFFFFFh
 L1:mov eax,eax
	loop L1
	pop ecx
	ret
innerLoop ENDP
END main
