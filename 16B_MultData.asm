;ASSUME把DS同data1关联,ES同data2相关联
;ASSUME告诉汇编器如何在编译时计算段中变量和标号的偏移地址
cseg SEGMENT 'CODE'
	ASSUME cs:cseg,ds:data1,es:data2,ss:mystack		;通常放在SEGMENT后
main PROC
	mov ax,data1			;使用段名,设置寄存器值
	mov ds,ax
	mov ax,SEG val2			;SEG获取val2所在段的段地址
	mov es,ax
	
	mov ax,val1				;ASSUME已经使用段data1
	mov bx,es:val2				;ASSUME已经使用段data2
	mov ax,4C00h
	int 21h
main ENDP
cseg ENDS

data1 SEGMENT 'DATA'
	val1 WORD 1001h
data1 ENDS

data2 SEGMENT 'DATA'
	val2 WORD 1002h
data2 ENDS

mystack SEGMENT para STACK 'STACK'
	BYTE 100h DUP('S')
mystack ENDS

END main 