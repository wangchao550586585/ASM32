Public _ReadSector
.model small	;С���ڴ�ģ��
.386			;����model֮��,�Ա��ñ���������16λ��

DiskIO STRUC
	startSector DD ?			;��ʼ������
	nmSectors   DW 1			;��������
	bufferOfs   DW ?			;������ƫ�Ƶ�ַ
	bufferSeg   DW ?			;���������ڵĶ�
DiskIO ENDS
.data
diskStruct DiskIO <>
.code
_ReadSector PROC NEAR C				
		;ARG�ؼ�����ָ�����̲���,�����Ժ�C++����˳��һ���ƶ�����
		;Borland TASM����ARG
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
		mov ax,7305h				;����������д
		mov cx,0FFFFh				;������0FFFFh
		mov dx,driveNumber			;��������
		mov bx,OFFSET diskStruct	;������
		mov si,0					;��ȡģʽ
		int 21h						;��ȡ��������
		popa
		leave
		ret
_ReadSector ENDP
END
