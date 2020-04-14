-------------定义结构
Employee STRUCT
	Idnum BYTE "000000000"			;9
	Lastname BYTE 30 DUP(0)			;30
	ALIGH	WORD					;add 1 byte
	Years	WORD 0
	ALIGH	DWORD					;add 2 byte
	SalaryHistory DWORD 0,0,0,0		;16
Employee ENDP						;60字节

-----------声明结构变量
.data
ALIGH DWORD				;根据DWORD对齐结构变量,为提升性能,结构变量应根据结构中类型尺寸最大的成员的类型进行对齐
point1	COORD <5,10>	;X=5,Y=10
point2	COORD <20>		;X=20
point3	COORD <>		;X=?,Y=?
point4	COORD 3 DUP(<0,0>)		;使用DUP声明结构数组,point4数组3元素X和Y初始化0
worker Employee<>		;默认初始值
worker Employee<"5555">	;只覆盖Idnum,当初始值比域短,其余位置空格填充
worker Employee{"5555"}	;只覆盖Idnum
worker Employee<,"5555">	;跳过对Idnum初始化
worker Employee<,,,2 DUP(2000)>;初始化SalaryHistory前二个值,如果数组类型域初始值比域短,剩余元素设0

---------结构域引用
TYPE Employee		;60字节
SIZEOF Employee		;60字节
SIZEOF worker		;60字节
TYPE Employee.SalaryHistory			;4
LENGTHOF Employee.SalaryHistory		;4
SIZEOF Employee.SalaryHistory		;16
TYPE Employee.Years					;2

-----------结构引用
.data
worker Employee <>
.code
mov dx,worker.Years
mov worker.SalaryHistory,2000		;第一个SalaryHistory
mov [worker.SalaryHistory+4],2000	;第二个SalaryHistory
mov edx,OFFSET worker.SalaryHistory	;获取结构变量中域的偏移地址

间接操作数,需要使用PTR
mov esi,OFFSET worker
mov ax,(Employee PTR [esi]).Years
mov ax,[esi].Years		;编译错误,Years并不足以确认某个特定结构

变址操作数
.data
department Employee 5 DUP(<>)
.code
mov esi,TYPE Employee		;esi=60可理解index=1
mov department[esi].Year,4	 

----------结构嵌套
Rectangle STRUCT
	UpperLeft COORD <>
	LowerRight COORD <>
Rectangle ENDS
声明如下
rect1 Rectangle <>
rect1 Rectangle {}
rect1 Rectangle {{10,10},{20,20}}
rect1 Rectangle <<10,10>,<20,20>>
引用
直接引用
mov rect1.UpperLeft.X,10
使用间接操作数访问
mov esi,OFFSET rect1
mov (Rectangle PTR [esi]).UpperLeft.Y,10
mov esi,OFFSET rect1.UpperLeft
mov (COORD PTR [esi]).Y,10
mov esi,OFFSET rect1.UpperLeft.Y
mov WORD PTR [esi],10

--------联合
所有域都从同一偏移地址开始,联合的大小=其中最长的域的长度
Integer UNION
		D WORD 1
		W DWORD 1
		B BYTE 1
Integer ENDS
嵌套在结构中的联合
structname STRUCT
	structure-field
	FileID Integer <>			;使用默认值

	;所有域只能有一个初始值,域中初始值应一样
	UNION FileID				;同上一样
		D WORD 1
		W DWORD 1
		B BYTE 1
	ENDS
structname ENDS

声明,联合只允许一个初始值
val Integer <123h>
val Integer <>
使用联合,可以使用不同大小的操作数而获得灵活性
mov val1.B,al
mov val1.W,ax
mov val1.D,eax


-------宏
mPutchar MACRO char:REQ,char2:<" ">		;REQ为必须参数,char2默认值为" "
	ECHO ECHO伪指令可以再控制台上显示此条信息
	push eax						;;单个;注释会在宏预处理时出现,2个;注释则不会出现
	mov al,char
	call WriteChar
	pop eax
ENDM
mPutchar 'A'		;可传递任何字符or字符ASCII码
预处理为:
	push eax
	mov al,'A'
	call WriteChar
	pop eax

makeString MACRO text
	.data
	string BYTE text,0
ENDM
如下调用会编译错误,因为string标号重复定义
makeString "hello"
makeString "word"
使用LOCAL定义string,每次宏展开时预处理器都会把标号的名字转换成一个唯一的标识符名
makeString MACRO text
	LOCAL string
	.data
	string BYTE text,0
ENDM

包含代码和数据的宏
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

宏内调用宏

-------------------条件汇编伪指令
检查缺少的参数
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
	
IF,ELSE,ENDIF与布尔表达式合用
;表达式不能包括寄存器OR变量名
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

对矩阵求和
调用:mCalc_row_sum index,OFFSET 数组名,每行占用字节数,BYTE
mCalc_row_sum MACRO index,arrayOffset,rowSize,eltType		;eltType类型,BYTE,WORD,DWORD
	LOCAL L1				;L1修改为宏内的LOCAL标号
		push ebx
		push ecx
		push esi

		mov eax,index
		mov ebx,arrayOffset
		mov ecx,rowSize

		;计算行的偏移地址
		mul ecx
		add ebx,eax
		;准备循环计数器
		shr ecx,(TYPE eltType/2)
		;初始化累加器和列索引
		mov eax,0
		mov esi,0

	L1:
		IFIDNI <eltType>,<DWORD>				;eltType是双字,movzx无法汇编
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

-----------宏函数
IsDefined MACRO symbol
	IFDEF symbol
		EXITM <-1>
	ELSE
		EXITM <0>
	ENDIF
ENDM
调用宏函数,列表参数必需()起来
IF IsDefined(RealMode)
	mov ax,@data
	mov ds,ax
ENDIF

--------------定义重复块
生成1-F0000000h之间的斐波拉契作为一系列编译时期的常量
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

定义结构,包含一个地理位置,以及降雨量和湿度的数组
WEEKS_PER_YEAR=52			;决定重复次数
WeatherReadings STRUCT
	location BYTE 50 DUP(0)
	REPEAT WEEKS_PER_YEAR
		LOCAL rainfall,humidity			;避免在汇编时循环重复定义可能导致的重复定义错误
		rainfall DWORD ?
		humidity DWORD ?
	ENDM
WeatherReadings ENDS

----FOR:遍历一个以逗号分隔的符号列表重复语句块
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
汇编成
.data
Fall999 SEMESTER <>
Spring2000 SEMESTER <>
Fall111 SEMESTER <>

----FORC:遍历一个字符串中的每个字符来重复语句块
FORC code ,<@#%$!<>			;"<>"2符号前面需要添加!,防止与FORC指令格式参数冲突
	BYTE "&code"
ENDM
内存中的数据为@#%$<
