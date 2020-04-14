;用随机整数填充一个数组,在屏幕显示
;整数写入2进制文件,关闭文件
;重新打开文件,读取整数屏幕显示
INCLUDE Irvine16.inc
.data
myArray		DWORD 50 DUP (?)
fileName	BYTE "binary array file.bin",0
fileHandle	WORD ?
commaStr	BYTE ", ",0
CreateFile=1
.code
main PROC
	mov ax,@data
	mov ds,ax

	.IF CreateFile EQ 1
		call FillTheArray			
		call DisplayTheArray
		call CreateTheFile
		call WaitMsg
		call Crlf
	.ENDIF
		call ReadTheFile
		call DisplayTheArray
	quit:
		call Crlf
	exit
main ENDP

FillTheArray PROC
	mov cx,LENGTHOF myArray
	mov si,0
L1:	mov eax,1000
	call RandomRange		;生成随机数0~999

	mov myArray[si],eax
	add si,TYPE myArray
	loop L1
	ret
FillTheArray ENDP

DisplayTheArray PROC
	mov cx,LENGTHOF myArray
	mov si,0
L1: mov eax,myArray[si]
	call WriteHex
	mov edx,0FFSET commaStr
	call WriteString
	add si,TYPE myArray
	loop L1
	ret
DisplayTheArray ENDP

CreateTheFile PROC
	mov ax,716Ch				;创建文件
	mov bx,1					;模式,只写
	mov cx,0					;普通文件
	mov dx,12h					;动作:创建/剪裁
	mov si,OFFSET fileName		;文件名
	int 21h						
	jc quit						;错误则退出
	mov fileHandle,ax			;保存句柄
	
	;向文件写入整型数组
	mov ah,40h					;写文件或设备
	mov bx,fileHandle
	mov cx,SIZEOF myArray
	mov dx,OFFSET myArray
	int 21h

	jc quit

	;关闭文件
	mov ah,3Eh
	mov bx,fileHandle
	int 21h
quit:
	ret
CreateTheFile ENDP

ReadTheFile PROC
	;打开文件,获取句柄
	mov ax,716Ch					
	mov bx,0				;模式:只读
	mov cx,0				;属性:普通
	mov dx,1				;打开已存在的文件
	mov si,OFFSET fileName
	int 21h
	jc quit
	mov fileHandle,ax

	;读取输入文件,然后关闭文件
	mov ah,3Fh					;读文件或设备
	mov bx,fileHandle			
	mov cx,SIZEOF myArray
	mov dx,OFFSET myArray
	int 21h

	jc quit
	mov ah,3Eh					;关闭文件
	mov bx,fileHandle
	int 21h
quit:
	ret
ReadTheFile ENDP

END main 