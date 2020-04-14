;汇编调用C,显示当前目录并要求用户输入一个文件名
.586
.MODEL flat,C
system PROTO,pCommand:PTR BYTE
printf PROTO,pString:PTR BYTE,args:VARARG
scanf PROTO,pFormat:PTR BYTE,pBuffer:PTR BYTE,args:VARARG
fopen PROTO,mode:PTR BYTE,filename:PTR BYTE
fclose PROTO,pFile:DWORD
BUFFER_SIZE=5000
.data
str1 BYTE "cls",0
str2 BYTE "dir/w",0
str3 BYTE "Enter the name of a file: ",0
str4 BYTE "%s",0
str5 BYTE "cannot open file",0dh,0ah,0
str6 BYTE "The file has been opened",0dh,0ah,0
modeStr BYTE "r",0

fileName BYTE 60 DUP(0)
pBuf DWORD ?
pFile DWORD ?

.code
asm_main PROC
	INVOKE system,ADDR str1
	INVOKE system,ADDR str2
	INVOKE printf,ADDR str3
	INVOKE scanf,ADDR str4,ADDR filename
	
	;打开文件
	INVOKE fopen,ADDR filename,ADDR modeStr
	mov pFile,eax

	.IF eax==0			;不能打开?
	INVOKE printf,ADDR str5
	jmp quit
	.ELSE
	INVOKE printf,ADDR str6
	.ENDIF

	;关闭文件
	INVOKE fclose,pFile
quit:
	ret
asm_main ENDP
END  