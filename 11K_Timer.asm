;测量2次调用GetTickCount之间经过的时间,并检查时间计数器值是否发生了回滚(超过49.7天)
INCLUDE Irvine32.inc
INCLUDE macros.inc
.data
startTime DWORD ?
.code
main PROC
	INVOKE GetTickCount
	mov startTime,eax

	mov ecx,10000100h
L1:
	imul ebx
	imul ebx
	imul ebx
	loop L1
	INVOKE GetTickCount
	cmp eax,startTime		
	jb error				;小于起始时间,时间回滚了
	sub eax,startTime
	call WriteDec
	mWrite <"毫秒值",0dh,0ah>
	jmp quit
error:
	mWrite "获取时间无效"
	mWrite <"时间超过了49.7天",0dh,0ah>
quit:
	exit
main ENDP
END main 
