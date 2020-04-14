Public _ReadSector
.model small	;小型内存模型
.386			;必须model之后,以便让编译器生成16位段

DiskIO STRUC
	startSector DD ?			;起始扇区号
	nmSectors   DW 1			;扇区数量
	bufferOfs   DW ?			;缓冲区偏移地址
	bufferSeg   DW ?			;缓冲区所在的段
DiskIO ENDS
.data
diskStruct DiskIO <>
.code
_ReadSector PROC NEAR C				
		;ARG关键字来指定过程参数,允许以和C++参数顺序一致制定参数
		;Borland TASM特有ARG
	ARG	bufferPtr:WORD,startSector:DWORD,driveNumber:WORD,numSectors:DWORD
		enter 0,0
		pusha
		mov eax,startSector
		mov diskStruct.startSector,eax
		mov ax,numSectors
		mov diskStruct.nmSectors,ax
		mov ax,bufferPtr
		mov diskStruct.bufferOfs,ax
		push ds
		pop diskStruct.bufferSeg
		mov ax,7305h				;绝对扇区读写
		mov cx,0FFFFh				;必须是0FFFFh
		mov dx,driveNumber			;驱动器号
		mov bx,OFFSET diskStruct	;扇区号
		mov si,0					;读取模式
		int 21h						;读取磁盘扇区
		popa
		leave
		ret
_ReadSector ENDP
END
