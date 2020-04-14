;MASM要求com程序使用微型内存模式,且必须使用ORG把程序代码起始地址设为100h
;MS-DOS加载COM程序时,创建256字节PSP(程序段前缀)
;0-0100	0100-X		X-FFFE
;PSP		代码		数据-堆栈
;CS,DS,ES,SS设置为指向PSP的基地址
;代码从偏移100h开始,堆栈区在段的最低端,SP=FFFEh
.model tiny
.code
org 100h			;必须放main之前
main PROC
	mov ah,9
	mov dx,OFFSET hello_message
	int 21h
	mov ax,4C00h
	int 21h
main ENDP
;因为没有单独的段用于存放数据,所以通常把变量放在主过程后面
;如果把数据放在程序开始,CPU就会试图执行数据,可以再程序开始使用JMP指令跳过数据区,跳到第一条实际指令处去执行
hello_message BYTE 'Hello, world!',0dh,ah,'$'
END main 