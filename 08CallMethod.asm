INCLUDE Irvine32.inc
EXTERN sub1@:PROC		;sub1@n:��������n��ʾ�Ĳ���ʹ�õ��ܶ�ջ�ռ�,4�ı���
.code
main PROC
	call sub1@
	exit
main ENDP
END main

�����ͷ���Ĭ�϶���������ģ��˽��
PUBLIC count,SYM1		;ʹ��public�����ض�����
SYM1=10
.data
count DWORD 0

�����ⲿ�����ͷ���
EXTERN name:type,���ڷ���(EQU,=����)����,type��ABS,���ڱ���,type�����ݶ�������,��BYTE,DWORD�Լ�PTR
EXTERN one:WORD,three:PTR BYTE,four:ABS

EXTERNDEF:�����PUBLIC��EXTERN
1:����һ��vars.inc�ļ�
EXTERN count:DWORD,SYM1:ABS
2:����sub1.asm,���ļ�����count��SYM1�Ķ���,���ڲ��ǳ�������ģ��,ENDʡ�Գ�����ڱ��
.386
.model flat,STDCALL
INCLUDE vars.inc
SYM1=10
.data
count DWORD 0
END
3:main�ļ�,INCLUDE vars.inc,��ֱ��ʹ��count,SYM1

