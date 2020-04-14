;在FPU堆栈上压入2浮点值,然后显示,接着读入用户输入2值,相乘并显示乘积
INCLUDE Irvine32.inc
INCLUDE macros.inc
.data
first REAL8 123.456
second REAL8 10.0
third REAL8 ?
.code 
main PROC
	FINIT
	fld first
	fld second
	call ShowFPUStack

	mWrite "Please enter a real number: "
	call ReadFloat				;从键盘读入一个浮点值并把它压入浮点栈
	mWrite "Please enter a real number: "
	call ReadFloat

	fmul ST(0),ST(1)
	mWrite "Their product is: "
	call WriteFloat			;在控制台以指定格式显示ST(0)值
	call Crlf
	exit
main ENDP
END main 
