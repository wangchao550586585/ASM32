.386
.model flat,stdcall
printf PROTO C,pString:PTR BYTE,args:VARARG			;VARARG:可变长度参数列表
scanf PROTO C,format:PTR BYTE,args:VARARG
printSingle PROTO C,
	aSingle:REAL4, 
	precision:DWORD

.stack 2000
.code 

asmMain PROC C
.data
	double1 REAL8 1234567.890123
	formatStr BYTE "%.3f",0dh,0ah,0				;不能使用特殊的转义字符,必须插入其对应的ASCII如:0ah,0dh
.code
	INVOKE printf,ADDR formatStr,double1

TAB=9
.data
	formatTwo BYTE "%.2f",TAB,"%.3f",0dh,0ah,0
	val1 REAL8 456.789
	val2 REAL8 864.231
.code
	INVOKE printf,ADDR formatTwo,val1,val2

.data
	strSingle BYTE "%f",0
	strDouble BYTE "%lf",0
	single1 REAL4 ?
	double2 REAL8 ?
.code
	;格式化偏移地址,存放变量的偏移地址
	INVOKE scanf,ADDR strSingle,ADDR single1
	INVOKE scanf,ADDR strDouble,ADDR double2

.data
valStr BYTE "float1 = %.3f",0dh,0ah,0
float1 REAL4 1234.567
.code
	fld	float1					; load float1 onto FPU stack
	sub	esp,8					; reserve runtime stack space
	fstp	qword ptr [esp]		; put on runtime stack as a double
	push	OFFSET valStr
	call	printf
	add	esp,12
	
	INVOKE printSingle, float1, 3
		
	ret
asmMain ENDP

END