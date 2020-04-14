;��ASCII���ʽ��ʾ����ĳ�������ĳ���
INCLUDE Irvine16.inc
Setcursor PROTO ,row:BYTE ,col:BYTE
EOLN EQU <0dh,0ah>
ESC_KEY =1Bh
DATA_ROW=5
DATA_COL=0
SECTOR_SIZE=512
READ_MODE=0

DiskIO STRUCT
	startSector DWORD ?				;��ʼ������
	numSector	WORD  1				;������
	bufferOfs	WORD buffer			;������ƫ�Ƶ�ַ
	bufferSeg	WORD @DATA			;���������ڶ�
DiskIO ENDS

.data
driveNumber BYTE ?					;��������(0=Ĭ��,1=A,2=B,3=C,��)
diskStruct DiskIO <>
buffer BYTE SECTOR_SIZE DUP(0),0	;һ������
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
	call ReadSector				;��ȡһ������
	jc L2						;�����������˳�
	call DisplaySector
	call ReadChar
	cmp al,ESC_KEY
	je	L3
	inc diskStruct.startSector	;��һ������
	jmp L1
L2:	mov dx,OFFSET strCannotRead	;������Ϣ
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
	mov ax,7305h				;���̶�д
	mov cx,-1					;����-1
	mov dl,driveNumber			;��������
	mov bx,OFFSET diskStruct	;������
	mov si,READ_MODE			;��ȡģʽ
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
	INVOKE SetCursor,curr_row,curr_col		;��������

	mov cx,SECTOR_SIZE
	mov bh,0					;��Ƶҳ0
L1:	push cx
	mov ah,0Ah					;��ʾ�ַ�
	mov al,[si]					;�ӻ�������ȡһ���ֽ�
	mov cx,1
	int 10h						;��ʾ,��Ϊ�������������2��������,��INT21�����ַ��ᱻ���˵�,������10h,���Ǵ˹��ܲ����Զ�������
								;������ʾ��ÿ���ַ���ѹ�������ƶ�һ���ַ�
	call MoveCursor
	inc si
	pop cx
	loop L1
	ret
DisplaySector ENDP

MoveCursor PROC
	cmp curr_col,79						;���һ��?
	jae L1								;��:ת��һ��
	inc curr_col						;��,����1
	jmp L2
L1:	mov curr_col,0						;��һ��
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