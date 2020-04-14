;16位实地址模式汇编
;使用MS-DOS在屏幕上输出HelloWorld
.MODEL small			;小型内存模式,代码在单独的段,数据和堆栈在另外一个段
.STACK 100h				;极少情况下512字节
.386					;可以使用32位寄存器
.data
message BYTE "Hello,world!",0dh,0ah
.code
main PROC
	;初始化DS寄存器指向数据段的起始地址
	mov ax,@data
	mov ds,ax

	mov ah,40h
	mov bx,1				;输出句柄,1表示控制台
	mov cx,SIZEOF message
	mov dx,OFFSET message
	int 21h
	.EXIT
main ENDP
END main