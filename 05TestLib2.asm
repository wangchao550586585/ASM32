;测试Irvine32链接库中的随机数生成过程
INCLUDE Irvine32.inc
TAB=9		;TAB的ASCII码
.code
main PROC
	call Randomize	;初始化随机数生成器
	call Rand1
	call Rand2
	exit 
main ENDP

Rand1 PROC
	;生成10个伪随机数
	mov ecx,10			
 L1:call Random32			;生成随机数
	call WriteDec			;以无符号十进制数格式显示
	mov al,TAB				;水平制表符
	call WriteChar			;显示水平制表符
	loop L1
	call Crlf
	ret
Rand1 ENDP

Rand2 PROC
	;生成10个在范围-50~49之间的伪随机数
		mov ecx,10
	L1: mov eax,100
		call RandomRange
		sub eax,50
		call WriteInt
		mov al,TAB
		call WriteChar
		loop L1
		call Crlf
		ret
Rand2 ENDP

END main
