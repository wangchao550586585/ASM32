;以ASCII码格式显示磁盘某个扇区的程序
INCLUDE Irvine16.inc
Setcursor PROTO ,row:BYTE ,col:BYTE
EOLN EQU <0dh,0ah>
ESC_KEY =1Bh
DATA_ROW=5
DATA_COL=0
SECTOR_SIZE=512
READ_MODE=0

DiskIO STRUCT
	startSector DWORD ?				;起始扇区号
	numSector	WORD  1				;扇区数
	bufferOfs	WORD buffer			;缓冲区偏移地址
	bufferSeg	WORD @DATA			;缓冲区所在段
DiskIO ENDS

.data
driveNumber BYTE ?					;驱动器号(0=默认,1=A,2=B,3=C,等)
diskStruct DiskIO <>
buffer BYTE SECTOR_SIZE DUP(0),0	;一个扇区
curr_row BYTE ?
curr_col BYTE ?

strLine			BYTE	EOLN,79 DUP(0C4h),EOLN,0
strHeading		BYTE	"Sector Display Program (Sector.ext)"
				BYTE	EOLN,EOLN,0
strAskSector	BYTE	"Enter starting sector number: ",0
strAskDrive		BYTE	"Enter drive number (1=A, 2=B, "
				BYTE	"3=C, 4=D, 5=E, 6=F): ",0
strCannotRead	BYTE	EOLN,"*** Cannot read the sector. "
				BYTE	"Press any key...",EOLN,0
strReadingSector BYTE	"Press Esc to quit, or any key to continute..."
				BYTE	EOLN,EOLN,"Reading sector: ",0
.code
main PROC
	mov ax,@data
	mov ds,ax
	call Clrscr
	mov dx,OFFSET strHeading
	call WriteString
	call AskForSectorNumber
L1:	call Clrscr
	call ReadSector				;读取一个扇区
	jc L2						;发生错误则退出
	call DisplaySector
	call ReadChar
	cmp al,ESC_KEY
	je	L3
	inc diskStruct.startSector	;下一个扇区
	jmp L1
L2:	mov dx,OFFSET strCannotRead	;错误信息
	call WriteString
	call ReadChar
L3:	call Clrscr
	exit
main ENDP

AskForSectorNumber PROC
	pusha
	mov dx,OFFSET strAskSector
	call WriteString
	call ReadInt
	mov disStruct.startSector,eax
	call Crlf
	mov dx,OFFSET strAskDrive
	call WriteString
	call ReadInt
	mov driveNumber,al
	call Crlf
	popa
	ret
AskForSectorNumber ENDP

ReadSector PROC
	pusha	
	mov ax,7305h				;磁盘读写
	mov cx,-1					;总是-1
	mov dl,driveNumber			;驱动器号
	mov bx,OFFSET diskStruct	;扇区号
	mov si,READ_MODE			;读取模式
	int 21h						
	popa
	ret
ReadSector ENDP

DisplaySector PROC
	mov dx,OFFSET strHeading
	call WriteString
	mov eax,diskStruct.startSector
	call WriteDec
	mov dx,OFFSET strLine
	call WriteString
	mov si,OFFSET buffer
	mov curr_row,DATA_ROW
	mov curr_COL,DATA_COL
	INVOKE SetCursor,curr_row,curr_col		;设置行列

	mov cx,SECTOR_SIZE
	mov bh,0					;视频页0
L1:	push cx
	mov ah,0Ah					;显示字符
	mov al,[si]					;从缓冲区中取一个字节
	mov cx,1
	int 10h						;显示,因为大多数扇区包含2进制数据,用INT21控制字符会被过滤掉,所以用10h,但是此功能并不自动跟随光标
								;所以显示完每个字符后把光标向右移动一个字符
	call MoveCursor
	inc si
	pop cx
	loop L1
	ret
DisplaySector ENDP

MoveCursor PROC
	cmp curr_col,79						;最后一列?
	jae L1								;是:转下一行
	inc curr_col						;否,列增1
	jmp L2
L1:	mov curr_col,0						;下一行
	inc curr_row
L2:	INVOKE SetCursor,curr_row,curr_col
	ret
MoveCursor ENDP

SetCursor PROC	USES dx,
	row:BYTE,col:BYTE
	mov dh,row
	mov dl,col
	call Gotoxy
	ret
SetCursor ENDP

END main 