;16位实地址模式
TITLE ADD and Subtract,Version 3
INCLUDE Irvine16.inc	

.data
val1 DWORD 10000h
val2 DWORD 40000h
val3 DWORD 20000h
finalVal DWORD ?

.code
main4 PROC
	mov ax,@data		;@data数据段的起始地址
	mov ds,ax

	mov eax,val1		;使用的是IA32处理器,依然可以使用32位寄存器
	add eax,val2
	sub eax,val3
	mov finalVal,eax
	call DumpRegs
	exit
main4 ENDP
END main4