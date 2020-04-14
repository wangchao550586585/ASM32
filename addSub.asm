TITLE Add and Subtract	;TITLE伪指令将整行标为注释
;整数相加减
INCLUDE Irvine32.inc	;INCLUDE伪指令从Irvine32.inc文件中复制必需的定义和设置信息
.code			;伪指令标记代码段的开始
main1 PROC		;PROC伪指令标识一个过程的开始,过程名为main
	mov eax,10000h
	add eax,40000h
	sub eax,20000h
	call DumpRegs	;调用一个显示CPU寄存器值的过程
	exit		;调用一个预定义的MS-WINDOWS函数来终止程序
main1 ENDP		;ENDP伪指令标记main过程的结束
END main1		;END伪指令标注该行是汇编源程序最后一行,编译器会忽略后面的所有内容,main是程序入口点名