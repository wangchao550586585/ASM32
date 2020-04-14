;��ȡFAT���ʹ��̵Ĵ��̷����ϵ�ʣ��ռ���Ϣ,�Լ�������С
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

	mov buffer.Level,0					;����Ϊ0
	mov di,OFFSET buffer				;������
	mov cx,SIZEOF buffer				;��������С
	mov dx,OFFSET DriveName				;�������������Ŀ��ַ���β���ַ���
	mov ax,7303h						;��ȡ����ʣ��ռ�
	int 21h
	jc error							;CF=1��ʧ��

	mov dx,OFFSET str1					;��Ĵ�С
	call WriteString
	call CalcVolumeSize
	call WriteDec
	call Crlf

	mov dx,OFFSET str2					;ʣ��ռ�
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
	shl eax,9						;����512
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