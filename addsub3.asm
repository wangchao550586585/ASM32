TITLE ADD and Subtract,Version 3
INCLUDE Irvine32.inc	

.data
val1 DWORD 10000h
val2 DWORD 40000h
val3 DWORD 20000h
finalVal DWORD ?

.code
main3 PROC
	mov eax,val1
	add eax,val2
	sub eax,val3
	mov finalVal,eax
	call DumpRegs
	exit
main3 ENDP
END main3