-------------����ṹ
Employee STRUCT
	Idnum BYTE "000000000"			;9
	Lastname BYTE 30 DUP(0)			;30
	ALIGH	WORD					;add 1 byte
	Years	WORD 0
	ALIGH	DWORD					;add 2 byte
	SalaryHistory DWORD 0,0,0,0		;16
Employee ENDP						;60�ֽ�

-----------�����ṹ����
.data
ALIGH DWORD				;����DWORD����ṹ����,Ϊ��������,�ṹ����Ӧ���ݽṹ�����ͳߴ����ĳ�Ա�����ͽ��ж���
point1	COORD <5,10>	;X=5,Y=10
point2	COORD <20>		;X=20
point3	COORD <>		;X=?,Y=?
point4	COORD 3 DUP(<0,0>)		;ʹ��DUP�����ṹ����,point4����3Ԫ��X��Y��ʼ��0
worker Employee<>		;Ĭ�ϳ�ʼֵ
worker Employee<"5555">	;ֻ����Idnum,����ʼֵ�����,����λ�ÿո����
worker Employee{"5555"}	;ֻ����Idnum
worker Employee<,"5555">	;������Idnum��ʼ��
worker Employee<,,,2 DUP(2000)>;��ʼ��SalaryHistoryǰ����ֵ,��������������ʼֵ�����,ʣ��Ԫ����0

---------�ṹ������
TYPE Employee		;60�ֽ�
SIZEOF Employee		;60�ֽ�
SIZEOF worker		;60�ֽ�
TYPE Employee.SalaryHistory			;4
LENGTHOF Employee.SalaryHistory		;4
SIZEOF Employee.SalaryHistory		;16
TYPE Employee.Years					;2

-----------�ṹ����
.data
worker Employee <>
.code
mov dx,worker.Years
mov worker.SalaryHistory,2000		;��һ��SalaryHistory
mov [worker.SalaryHistory+4],2000	;�ڶ���SalaryHistory
mov edx,OFFSET worker.SalaryHistory	;��ȡ�ṹ���������ƫ�Ƶ�ַ

��Ӳ�����,��Ҫʹ��PTR
mov esi,OFFSET worker
mov ax,(Employee PTR [esi]).Years
mov ax,[esi].Years		;�������,Years��������ȷ��ĳ���ض��ṹ

��ַ������
.data
department Employee 5 DUP(<>)
.code
mov esi,TYPE Employee		;esi=60�����index=1
mov department[esi].Year,4	 

----------�ṹǶ��
Rectangle STRUCT
	UpperLeft COORD <>
	LowerRight COORD <>
Rectangle ENDS
��������
rect1 Rectangle <>
rect1 Rectangle {}
rect1 Rectangle {{10,10},{20,20}}
rect1 Rectangle <<10,10>,<20,20>>
����
ֱ������
mov rect1.UpperLeft.X,10
ʹ�ü�Ӳ���������
mov esi,OFFSET rect1
mov (Rectangle PTR [esi]).UpperLeft.Y,10
mov esi,OFFSET rect1.UpperLeft
mov (COORD PTR [esi]).Y,10
mov esi,OFFSET rect1.UpperLeft.Y
mov WORD PTR [esi],10

--------����
�����򶼴�ͬһƫ�Ƶ�ַ��ʼ,���ϵĴ�С=���������ĳ���
Integer UNION
		D WORD 1
		W DWORD 1
		B BYTE 1
Integer ENDS
Ƕ���ڽṹ�е�����
structname STRUCT
	structure-field
	FileID Integer <>			;ʹ��Ĭ��ֵ

	;������ֻ����һ����ʼֵ,���г�ʼֵӦһ��
	UNION FileID				;ͬ��һ��
		D WORD 1
		W DWORD 1
		B BYTE 1
	ENDS
structname ENDS

����,����ֻ����һ����ʼֵ
val Integer <123h>
val Integer <>
ʹ������,����ʹ�ò�ͬ��С�Ĳ���������������
mov val1.B,al
mov val1.W,ax
mov val1.D,eax


-------��
mPutchar MACRO char:REQ,char2:<" ">		;REQΪ�������,char2Ĭ��ֵΪ" "
	ECHO ECHOαָ������ٿ���̨����ʾ������Ϣ
	push eax						;;����;ע�ͻ��ں�Ԥ����ʱ����,2��;ע���򲻻����
	mov al,char
	call WriteChar
	pop eax
ENDM
mPutchar 'A'		;�ɴ����κ��ַ�or�ַ�ASCII��
Ԥ����Ϊ:
	push eax
	mov al,'A'
	call WriteChar
	pop eax

makeString MACRO text
	.data
	string BYTE text,0
ENDM
���µ��û�������,��Ϊstring����ظ�����
makeString "hello"
makeString "word"
ʹ��LOCAL����string,ÿ�κ�չ��ʱԤ����������ѱ�ŵ�����ת����һ��Ψһ�ı�ʶ����
makeString MACRO text
	LOCAL string
	.data
	string BYTE text,0
ENDM

������������ݵĺ�
makeString MACRO text
	LOCAL string
	.data
	string BYTE text,0
	.code
	push edx
	mov edx,OFFSET string
	call WriteString
	pop edx
ENDM

���ڵ��ú�

-------------------�������αָ��
���ȱ�ٵĲ���
mWriteStr MACRO string
	IFB <string>
		ECHO --------------------------
		ECHO * ERROR :parameter missing in mWriteStr
		ECHO --------------------------
		EXITM
	ENDIF
	push edex
	mov edx,OFFSET string
	call WriteString
	pop edx
ENDM
	
IF,ELSE,ENDIF�벼�����ʽ����
;���ʽ���ܰ����Ĵ���OR������
mGotoxyConst MACRO X:REQ,Y:REQ
	LOCAL ERRS
	ERRS=0
	IF(X LT 0)OR(X GT 79)
		ECHO *****
		ERRS=1
	ENDIF
	IF(Y LT 0)OR(Y GT 24)
		ECHO *****
		ERRS=ERRS+1
	ENDIF
	IF ERRS GT 0
		EXITM
	ENDIF
	push edx
	mov dh,Y
	mov dl,X
	call Gotoxy
	pop edx
ENDM

�Ծ������
����:mCalc_row_sum index,OFFSET ������,ÿ��ռ���ֽ���,BYTE
mCalc_row_sum MACRO index,arrayOffset,rowSize,eltType		;eltType����,BYTE,WORD,DWORD
	LOCAL L1				;L1�޸�Ϊ���ڵ�LOCAL���
		push ebx
		push ecx
		push esi

		mov eax,index
		mov ebx,arrayOffset
		mov ecx,rowSize

		;�����е�ƫ�Ƶ�ַ
		mul ecx
		add ebx,eax
		;׼��ѭ��������
		shr ecx,(TYPE eltType/2)
		;��ʼ���ۼ�����������
		mov eax,0
		mov esi,0

	L1:
		IFIDNI <eltType>,<DWORD>				;eltType��˫��,movzx�޷����
			mov edx,eltType PTR[ebx+esi*(TYPE eltType)]
		ELSE
			movzx edx,eltType PTR[ebx+esi*(TYPE eltType)]
		ENFIF
		add eax,edx
		inc esi
		loop L1
	
		pop esi
		pop ecx 
		pop ebx
ENDM

-----------�꺯��
IsDefined MACRO symbol
	IFDEF symbol
		EXITM <-1>
	ELSE
		EXITM <0>
	ENDIF
ENDM
���ú꺯��,�б��������()����
IF IsDefined(RealMode)
	mov ax,@data
	mov ds,ax
ENDIF

--------------�����ظ���
����1-F0000000h֮���쳲�������Ϊһϵ�б���ʱ�ڵĳ���
.data
val1=1
val2=1
DWORD val1,val2
val3=val1+val2
WHILE val3 LT 0F00000000h
	DWORD val3
	val1=val2
	val2=val3
	val3=val1+val2
ENDM

����ṹ,����һ������λ��,�Լ���������ʪ�ȵ�����
WEEKS_PER_YEAR=52			;�����ظ�����
WeatherReadings STRUCT
	location BYTE 50 DUP(0)
	REPEAT WEEKS_PER_YEAR
		LOCAL rainfall,humidity			;�����ڻ��ʱѭ���ظ�������ܵ��µ��ظ��������
		rainfall DWORD ?
		humidity DWORD ?
	ENDM
WeatherReadings ENDS

----FOR:����һ���Զ��ŷָ��ķ����б��ظ�����
COURSE STRUCT
	Number BYTE 9 DUP(?)
	Credits BYTE ?
COURSE ENDS
SEMESTER STRUCT
	Courses COURSE 6 DUP(<>)
	NumCourses WORD ?
SEMESTER ENDS
.data
FOR semName,<Fall999,Spring2000,Fall111>
	semName SEMESTER <>
ENDM
����
.data
Fall999 SEMESTER <>
Spring2000 SEMESTER <>
Fall111 SEMESTER <>

----FORC:����һ���ַ����е�ÿ���ַ����ظ�����
FORC code ,<@#%$!<>			;"<>"2����ǰ����Ҫ���!,��ֹ��FORCָ���ʽ������ͻ
	BYTE "&code"
ENDM
�ڴ��е�����Ϊ@#%$<
