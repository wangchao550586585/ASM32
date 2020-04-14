.model tiny
.code
org 100h			;必须放main之前
main PROC
;因为没有单独的段用于存放数据,所以通常把变量放在主过程后面
;如果把数据放在程序开始,CPU就会试图执行数据,可以再程序开始使用JMP指令跳过数据区,跳到第一条实际指令处去执行
	jmp start
	hello_message BYTE 'Hello, world!',0dh,ah,'$'
start:
	mov ah,9
	mov dx,OFFSET hello_message
	int 21h
	mov ax,4C00h
	int 21h
main ENDP
END main 