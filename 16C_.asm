;��ͬģ��Դ����,Ҳ���������ͬһ������,ֻҪ�Բ�ͬģ���ڵĶ�ʹ��ͬ�������ֲ�ȫ��ָ��PUBLCI��Ϸ�ʽ����.
;2������ģ��,2�����,���ݶκ�һ����ջ��,�����ϳ�3����CSEG,DSEG,SSEG
;CSEG,DSEGʹ��PUBLIC��Ϸ�ʽ
;CSEG��ʹ��BYTE���뷽ʽ,������2�����������ʱ����ֿ�϶

EXTRN var2:WORD
EXTERN subroutine_1:PROC

cseg SEGMENT BYTE PUBLIC 'CODE'
ASSUME cs:cseg,ds:dseg,ss:sseg
main PROC
	mov ax,dseg
	mov ds,ax
	mov ax,var1
	mov bx,var2
	call subroutine_1
	mov ax,4C00h
	int 21h
main ENDP
cseg ENDS

dseg SEGMENT WORD PUBLIC 'DATA'
	var1 WORD 1000h
dseg ENDS

sseg SEGMENT STACK 'STACK'
	BYTE 100h dup('S')
sseg ENDS

END main 