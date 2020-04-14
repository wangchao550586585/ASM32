;编写高效查找数组中值的汇编代码
.586
.model flat,C				;指定C调用约定,并且为外部C++程序调用的每个过程声明原形PROTO,C语言中使用extern关键字声明外部汇编语言
AsmFindArray PROTO,
	srchVal:DWORD,arrayPtr:PTR DWORD,count:DWORD
	.code

AsmFindArray PROC USES edi,
	srchVal:DWORD,arrayPtr:PTR DWORD,count:DWORD
	true=1
	false=0
	mov eax,srchVal
	mov ecx,count
	mov edi,arrayPtr
	repne scasd		;搜索
	jz returnTrue	;如果找到ZF=1
returnFalse:
	mov al,false
	jmp short exit
returnTrue:
	mov al,true
exit:
	ret
AsmFindArray ENDP
END