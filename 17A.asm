---------���ظ���ֵ
FLD:���ظ���ֵ,����һ����������FPU��ջ��(ST0),������������32,64,80λ���ڴ������(REAL4,REAL8,REAL10)������һ������Ĵ���
	FLD m32fp
	FLD m64fp
	FLD m80fp
	FLD ST(i)

�ڴ������������
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

����2��ֱ�Ӳ�������FPU��ջ
.data
dblOne REAL8 234.56
dblTwo REAL8 10.1
.code
fld dblOne			;ST(0)=dblOne
fld dblTwo			;ST(0)=dblTwo,ST(1)=dblOne

FILD:��16,32,64λ������Դ������ת����˫���ȸ�������������ص�ST(0),Դ�������ķ���λ����

���س���
FLD1�ڼĴ�����ѹ��1.0
FLDL2T�ڼĴ�����ѹ��lb10
FLDL2E�ڼĴ�����ѹ��lbe
FLDPI�ڼĴ�����ѹ���
FLDLG2�ڼĴ�����ѹ��lg2
FLDLN2�ڼĴ�����ѹ��ln2
FLDZ�ڼĴ�����ѹ��0.0

-------------�洢����ֵ
FST:����FPU��ջ���Ĳ��������ڴ���,������������32,64,80�ڴ������(REAL4/8/10)������һ������Ĵ���
FST m32fp
FST m64fp
FST m80fp
FST ST(i)
FSTP:��FSTһ��,�ҵ���ST(0)
FIST:��ST(0)ֵת�������з����������ѽ���洢��Ŀ�Ĳ�������,ֵ���Դ洢����or˫����.֧�ֲ�����ͬFST

-------------����ֵ�Ƚ�
FCOM/FCOMP/FCOMPP:�Ƚ�ST(0)��Դ������,Դ�������������ڴ��������FPU�Ĵ���,FCOMP����ST(0),FCOMPP��2��ST(0)
�����룺C3/2/0����FPU������˵���˸���ֵ�ȽϵĽ��,ͼƬFCOMPP���õ�������
�Ƚ���2ֵ��������FPU�������,����Ҫ�����������֧��ת��Ŀ�ı�Ŵ�,��������
	FNSTSW AX		;ʹ��FNSTSWָ���FPU״̬��AX
	SAHF			;ʹ��SAHFָ���AH���Ƶ�EFLAGS�Ĵ�����
֮��Ϳ���ʹ��JAE,JBE,JZ֮���ָ����
���ӣ�
	double x=1.2
	double y=3.0
	int n=0
	if(x<y)n=1
	�������:
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
Intel P6ϵ�д�����������FCOMIָ��,�ȽϺ�ֱ���������־,��ż��־,��λ��־
	FCOMI ST(0),ST(i)
	�������:
	.data
	x REAL8 1.2
	y REAL8 3.0
	N DWORD 0
	.code
	fld x			
	fld y
	FCOMI ST(0),ST(1)		;FCOMI�������ڴ������
	jnb L1
	mov n,1
	L1:


--------------�Ƚ��Ƿ����
sqrt(2)*sqrt(2)-2.0�ᵼ�½������0
��ȷ�Ƚϸ�����X��Y�Ƿ����,ȡ���ֵ�ľ���ֵ(|x-y|)�����û��Զ����һ��С���������Ƚ�
.data
	epsilon REAL8 1.0E-12
	val2 REAL8 0.0
	val3 REAL8 1.001E-13
.code
	;if(val2==val3),��ʾֵ���
	fld epsilon
	fld val2
	fsub val3
	fabs
	fcomi ST(0),ST(1)			;ST(0)<ST(1),CF=1,ZF=0 С���ٽ�ֵ�����,�����򲻵�
	ja skip
	mWrite <"Values are equals",0dh,0ah>
skip:



--------------�쳣��ͬ��
δ���ε��쳣����ʱ,��ǰִ�еĸ���ָ��ж�,FPU�����쳣�¼��ź�,
��һ������ָ���FWAIT(WAIT)ָ��Ҫִ��ʱ,FPU����Ƿ���δ���쳣�����,����ø����쳣�������
�����һ��ָ��������ָ���ϵͳָ��,���ǽ�����ִ��,������δ���쳣
��ʹ��WAIT��FWAIT���Ǳ�ڵ�ͬ������
fild intVal		;�洢ST(0)��intVal
fwait			;�ȴ�δ���쳣
inc intVal		

--------����
���ʽ
valD=-valA+(valB*valC)
	.data
	valA REAL8 1.5
	valB REAL8 2.5
	valC REAL8 3.0
	valD REAL8 ?;
	.code
	fld valA
	fchs			;�ı�valA����
	fld valB
	fmul valC
	fadd
	fstp valD			

����֮��
ARRAY_SIZE=20
.data
sngArray REAL8 ARRAY_SIZE DUP(?)
.code
mov esi,0
fldz				;����ջѹ��0.0
mov ecx,ARRAY_SIZE
L1:fld sngArray[esi]	;�����ڴ��������ST(0)
   fadd					;ST(0)��ST(1)��Ӻ�ST(0)��ջ
   add esi,TYPE REAL8
   loop L1
   call WriteFloat

ƽ����֮��
.data
valA REAL 25.0
valB REAL 36.0
.code
fld valA
fsqrt		;ST(0)=sqrt(valA)
fld valB
fsqrt		
fadd

����ĵ��
(array[0]*array[1])+(array[2]*array[3]):��֮Ϊ���
.data
array REAL4 6.0,2.0,4.5,3.2
fld array
fmul [array+4]
fld [array+8]
fmul [array+12]
fadd

-----------------���ģʽ����(��������ʵ������)
int N=20
double X=3.5
double Z=N+X
�ȼۻ������
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
fist Z		;���Ͻ���,�洢ST(0)���ڴ�������������
�ı����ģʽ:FPU�����ֵ�RC������ָ�����Ƶ�����
fstcw ctrlWord				;�洢������
or ctrlWord,110000000000b	;����RC=���÷�ʽ,�޸�RCλ10��λ11
;and ctrlWord,001111111111b	;���ý���ģʽ��Ĭ��
fldcw ctrlWord				;���ؿ�����


-----------------���κ�δ���ε��쳣
�����쳣Ĭ�������ε�,��˸����쳣����ʱ,�������������һ��Ĭ��ֵ������������ִ��
�رնԳ����쳣������:
1:�洢FPU��������һ��16λ������
2:���λ2(�����־)
3:���ر�������������
.data
ctrlWord WORD ?
.code
fstcw ctrlWord
and ctrlWord,1111111111111011b			;�رնԳ����쳣������
fldcw ctrlWrod							;���ػ�FPU��
