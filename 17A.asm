---------加载浮点值
FLD:加载浮点值,复制一个浮点数到FPU的栈顶(ST0),操作数可以是32,64,80位的内存操作数(REAL4,REAL8,REAL10)或另外一个浮点寄存器
	FLD m32fp
	FLD m64fp
	FLD m80fp
	FLD ST(i)

内存操作数的类型
.data
array REAL8 10 DUP(?)
.code
fld array
fld [array+16]
fld REAL8 PTR [esi]
fld array[esi]
fld array[esi*8]
fld array[esi*TYPE array]
fld REAL8 PTR[ebx+esi]
fld array[ebx+esi]
fld array[ebx+esi*TYPE array]

加载2个直接操作数到FPU堆栈
.data
dblOne REAL8 234.56
dblTwo REAL8 10.1
.code
fld dblOne			;ST(0)=dblOne
fld dblTwo			;ST(0)=dblTwo,ST(1)=dblOne

FILD:把16,32,64位的整数源操作数转换成双精度浮点数并把其加载到ST(0),源操作数的符号位保留

加载常量
FLD1在寄存器上压入1.0
FLDL2T在寄存器上压入lb10
FLDL2E在寄存器上压入lbe
FLDPI在寄存器上压入π
FLDLG2在寄存器上压入lg2
FLDLN2在寄存器上压入ln2
FLDZ在寄存器上压入0.0

-------------存储浮点值
FST:复制FPU的栈顶的操作数到内存中,操作数可以是32,64,80内存操作数(REAL4/8/10)或另外一个浮点寄存器
FST m32fp
FST m64fp
FST m80fp
FST ST(i)
FSTP:和FST一样,且弹出ST(0)
FIST:把ST(0)值转换车成有符号整数并把结果存储到目的操作数中,值可以存储在字or双字中.支持操作数同FST

-------------浮点值比较
FCOM/FCOMP/FCOMPP:比较ST(0)和源操作数,源操作数可以是内存操作数或FPU寄存器,FCOMP弹出ST(0),FCOMPP弹2次ST(0)
条件码：C3/2/0三个FPU条件码说明了浮点值比较的结果,图片FCOMPP设置的条件码
比较了2值并设置了FPU条件码后,还需要根据条件码分支跳转到目的标号处,步骤如下
	FNSTSW AX		;使用FNSTSW指令把FPU状态送AX
	SAHF			;使用SAHF指令把AH复制到EFLAGS寄存器中
之后就可以使用JAE,JBE,JZ之类的指令了
例子：
	double x=1.2
	double y=3.0
	int n=0
	if(x<y)n=1
	汇编如下:
	.data
	x REAL8 1.2
	y REAL8 3.0
	N DWORD 0
	.code
	fld x			;ST(0)=x
	fcomp y
	fnstsw ax
	sahf
	jnb L1
	mov n,1
	L1:
Intel P6系列处理器引入了FCOMI指令,比较后直接设置零标志,奇偶标志,进位标志
	FCOMI ST(0),ST(i)
	汇编如下:
	.data
	x REAL8 1.2
	y REAL8 3.0
	N DWORD 0
	.code
	fld x			
	fld y
	FCOMI ST(0),ST(1)		;FCOMI不接收内存操作数
	jnb L1
	mov n,1
	L1:


--------------比较是否相等
sqrt(2)*sqrt(2)-2.0会导致结果不是0
正确比较浮点数X和Y是否相等,取其差值的绝对值(|x-y|)并和用户自定义的一个小的正整数比较
.data
	epsilon REAL8 1.0E-12
	val2 REAL8 0.0
	val3 REAL8 1.001E-13
.code
	;if(val2==val3),显示值相等
	fld epsilon
	fld val2
	fsub val3
	fabs
	fcomi ST(0),ST(1)			;ST(0)<ST(1),CF=1,ZF=0 小于临界值则相等,大于则不等
	ja skip
	mWrite <"Values are equals",0dh,0ah>
skip:



--------------异常的同步
未屏蔽的异常发生时,当前执行的浮点指令被中断,FPU产生异常事件信号,
下一条浮点指令或FWAIT(WAIT)指令要执行时,FPU检查是否有未决异常如果有,则调用浮点异常处理程序
如果下一条指令是整数指令或系统指令,他们将立即执行,不会检查未决异常
可使用WAIT和FWAIT解决潜在的同步问题
fild intVal		;存储ST(0)到intVal
fwait			;等待未决异常
inc intVal		

--------例子
表达式
valD=-valA+(valB*valC)
	.data
	valA REAL8 1.5
	valB REAL8 2.5
	valC REAL8 3.0
	valD REAL8 ?;
	.code
	fld valA
	fchs			;改变valA符号
	fld valB
	fmul valC
	fadd
	fstp valD			

数组之和
ARRAY_SIZE=20
.data
sngArray REAL8 ARRAY_SIZE DUP(?)
.code
mov esi,0
fldz				;浮点栈压入0.0
mov ecx,ARRAY_SIZE
L1:fld sngArray[esi]	;加载内存操作数到ST(0)
   fadd					;ST(0)和ST(1)相加后ST(0)出栈
   add esi,TYPE REAL8
   loop L1
   call WriteFloat

平方根之和
.data
valA REAL 25.0
valB REAL 36.0
.code
fld valA
fsqrt		;ST(0)=sqrt(valA)
fld valB
fsqrt		
fadd

数组的点积
(array[0]*array[1])+(array[2]*array[3]):称之为点积
.data
array REAL4 6.0,2.0,4.5,3.2
fld array
fmul [array+4]
fld [array+8]
fmul [array+12]
fadd

-----------------混合模式运算(浮点数和实数运算)
int N=20
double X=3.5
double Z=N+X
等价汇编如下
.data
N SDWORD 20
X REAL8 3.5
Z REAL8 ?
.code
fild N
fadd X
fstp Z

int N=20
double X=3.5
int Z=(int)(N+X)
<==>
fild N
fadd X
fist Z		;向上近似,存储ST(0)到内存整数操作数中
改变近似模式:FPU控制字的RC域允许指定近似的类型
fstcw ctrlWord				;存储控制字
or ctrlWord,110000000000b	;设置RC=剪裁方式,修改RC位10和位11
;and ctrlWord,001111111111b	;重置近似模式至默认
fldcw ctrlWord				;加载控制字


-----------------屏蔽和未屏蔽的异常
浮点异常默认是屏蔽的,因此浮点异常发生时,处理器给结果赋一个默认值并继续安静的执行
关闭对除零异常的屏蔽:
1:存储FPU控制字至一个16位变量中
2:清除位2(除零标志)
3:加载变量至控制字中
.data
ctrlWord WORD ?
.code
fstcw ctrlWord
and ctrlWord,1111111111111011b			;关闭对除零异常的屏蔽
fldcw ctrlWrod							;加载回FPU中
