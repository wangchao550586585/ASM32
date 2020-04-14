;使用动态内存分配创建一个1000字节的数组,使用的是进程的默认堆
INCLUDE Irvine32.inc
.data
ARRAY_SIZE=1000
FILL_VAL EQU 0FFh
hHeap HANDLE ?					;进程堆的句柄
pArray DWORD ?					;内存块的指针
newHeap DWORD ?					;新堆的句柄
str1 BYTE "Heap size is: ",0
.code
main PROC
	INVOKE GetProcessHeap				;获取程序默认堆的句柄
	.IF eax==NULL						;失败了?
	call WriteWindowsMsg
	jmp quit
	.ELSE
	mov hHeap,eax
	.ENDIF
	call allocate_array
	jnc arrayOk							;失败了?(CF=1)
	call WriteWindowsMsg
	call Crlf
	jmp quit
arrayOk:								;成功,可以填充数组
	call fill_array
	call display_array
	call Crlf

	INVOKE HeapFree,hHeap,0,pArray		;释放从堆中分配的内存块
quit:
	exit
main ENDP

allocate_array PROC USES eax
	INVOKE HeapAlloc,hHeap,HEAP_ZERO_MEMORY,ARRAY_SIZE
	.IF eax==NULL
		stc					;返回时,CF=1
	.ELSE		
		mov pArray,eax		;保存指针
		clc					;返回时CF=0
	.ENDIF
	ret
allocate_array ENDP

fill_array PROC USES ecx edx esi
	mov ecx,ARRAY_SIZE
	mov esi,pArray
L1:	mov BYTE PTR [esi],FILL_VAL
	inc esi
	loop L1
	ret
fill_array ENDP

display_array PROC USES eax ebx ecx esi
	MOV ecx,ARRAY_SIZE
	mov esi,pArray
L1:	mov al,[esi]
	mov ebx,TYPE BYTE
	call WriteHexB
	inc esi
	loop L1
	ret
display_array ENDP
END main 

