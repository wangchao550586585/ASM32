;有多个代码段的程序
.model small,stdcall				;在小内存模式中,.CODE伪指令使汇编器生成一个名为_TEXT的段
.stack 100h							;在中大巨型模式中的程序,每个源代码模块(文件名)都被赋予不同段名字,格式:模块名_TEXT
WriteString PROTO
.data
msg1 db "First Message",0dh,0ah,0
msg2 db "Second Message",0dh,0ah,"$"
.code						;_TEXT段包含main过程
main PROC
	mov ax,@data
	mov dx,ax

	mov dx,OFFSET msg1
	call WriteString		;近调用,调用本书16位链接库中例程,这些代码只能在名为_TEXT的段中
	call Display			;远调用,
	.exit					
main ENDP

;不管内存模式如何,都可以在同一个模块中声明多个代码段,code伪指令后面接可选的段名
.code OtherCode				;otherCode段包含Display过程,Display必须有一个FAR修饰符,表示通知汇编器生成远调用(FAR)指令
							;远调用会在堆栈上保存段地址和偏移地址
Display PROC FAR
	mov ah,9
	mov dx,offset msg2
	int 21h
	ret
Display ENDP
END main 