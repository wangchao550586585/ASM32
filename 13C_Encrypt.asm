;从标准输入上读取每个字符,使用XOR指令改变字符,并把改变后字符送入标准输出
;重定向输入意味着输入来自文本而非键盘
;Encrypt < infile.text >outfile.text 从输入文件输出到输出文件
INCLUDE Irvine16.inc
XORVAL=239
.code
main PROC
	mov ax,@data
	mov ds,ax
L1:
	mov ah,6		;直接控制台输入
	mov dl,0FFh		;不等待字符
	int 21h			;al=字符
	jz L2			;ZF=1则退出
	xor al,XORVAL
	mov ah,6		;写入标准输出
	mov dl,al
	int 21h
	jmp L1
L2:	exit
main ENDP
END main