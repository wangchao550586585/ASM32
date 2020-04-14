;用户输入一个整数,对整数*2,显示乘积,C++进行输入输出
INCLUDE Irvine32.inc
askForInteger PROTO C
showInt PROTO C,value:SDWORD,outWidth:DWORD
OUT_WIDTH=8
ENDING_POWER=10
.data
intVal DWORD ?
.code
SetTextOutColor PROC C,
		color:DWORD
		mov eax,color
		call SetTextColor
		call Clrscr
		ret
SetTextOutColor ENDP

DisplayTable PROC C
	INVOKE askForInteger			;调用C++函数
	mov intVal,eax					;保存整数
	mov ecx,ENDING_POWER			;循环计数器
L1:	push ecx						;C++函数并不会保存/恢复通用寄存器,在这里保存ecx	
	shl intVal,1					;*2
	INVOKE showInt,intVal,OUT_WIDTH
	
	;-----------不用INVOKE
	;push OUT_WIDTH		;按照规定反向传参
	;push intVal
	;call showInt
	;add esp,8			清理堆栈

	pop ecx
	loop L1
	ret
DisplayTable ENDP
END