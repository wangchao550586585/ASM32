;��FPU��ջ��ѹ��2����ֵ,Ȼ����ʾ,���Ŷ����û�����2ֵ,��˲���ʾ�˻�
INCLUDE Irvine32.inc
INCLUDE macros.inc
.data
first REAL8 123.456
second REAL8 10.0
third REAL8 ?
.code 
main PROC
	FINIT
	fld first
	fld second
	call ShowFPUStack

	mWrite "Please enter a real number: "
	call ReadFloat				;�Ӽ��̶���һ������ֵ������ѹ�븡��ջ
	mWrite "Please enter a real number: "
	call ReadFloat

	fmul ST(0),ST(1)
	mWrite "Their product is: "
	call WriteFloat			;�ڿ���̨��ָ����ʽ��ʾST(0)ֵ
	call Crlf
	exit
main ENDP
END main 
