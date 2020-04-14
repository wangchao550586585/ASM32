;获取FAT类型磁盘的磁盘分区上的剩余空间信息,以及分区大小
INCLUDE Irvine16.inc
.data
buffer ExtGetDskFreSpcStruct <>
driveName BYTE "C:\",0
str1	BYTE "Volume size (KB): ",0
str2	BYTE "Free space (KB): ",0
str3	BYTE "Function call failed.",0dh,0ah,0
.code
main PROC
	mov ax,@data
	mov ds,ax
	mov es,ax

	mov buffer.Level,0					;必须为0
	mov di,OFFSET buffer				;缓冲区
	mov cx,SIZEOF buffer				;缓冲区大小
	mov dx,OFFSET DriveName				;包含驱动器名的空字符结尾的字符串
	mov ax,7303h						;获取磁盘剩余空间
	int 21h
	jc error							;CF=1则失败

	mov dx,OFFSET str1					;卷的大小
	call WriteString
	call CalcVolumeSize
	call WriteDec
	call Crlf

	mov dx,OFFSET str2					;剩余空间
	call WriteString
	call CalcVolumeFree
	call WriteDec
	call Crlf
	jmp quit
error:
	mov dx,OFFSET str3
	call WriteString
quit:
	exit
main ENDP

CalcVolumeSize PROC
	mov eax,buffer.SectorPerCluster
	shl eax,9						;乘以512
	mul buffer.TotalClusters
	mov ebx,1024
	div ebx
	ret
CalcVolumeSize ENDP

CalcVolumeFree PROC
	mov eax,buffer.SectorsPerCluster
	shl eax,9
	mul buffer.AvailableClusters
	mov ebx,1024
	div ebx
	ret
CalcVolumeFree ENDP
END main 