TITLE Add and Subtract
.386		;cpu最低要求intel386
.model flat,stdcall		;model伪指令指示汇编器为保护模式程序生成代码,stdcall允许调用MS-Windows函数
.stack 4096
ExitProcess PROTO,dwExitCode:DWORD		;2条PROTO伪指令声明该程序使用的过程原型:
DumpRegs PROTO							;ExitProcess是一个MS-Windows函数,终止当前程序(进程);DumpRegs是Irvine32链接库中显示寄存器的过程
.code
main2 PROC
	mov eax,10000h
	add eax,20000h
	sub eax,20000h
	call DumpRegs
	INVOKE ExitProcess,0	;调用ExitProcess结束执行,传递给该函数的参数是返回码0,INVOKE是一个调用过程或函数的汇编伪指令
main2 ENDP
END main2