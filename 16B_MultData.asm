;ASSUME��DSͬdata1����,ESͬdata2�����
;ASSUME���߻��������ڱ���ʱ������б����ͱ�ŵ�ƫ�Ƶ�ַ
cseg SEGMENT 'CODE'
	ASSUME cs:cseg,ds:data1,es:data2,ss:mystack		;ͨ������SEGMENT��
main PROC
	mov ax,data1			;ʹ�ö���,���üĴ���ֵ
	mov ds,ax
	mov ax,SEG val2			;SEG��ȡval2���ڶεĶε�ַ
	mov es,ax
	
	mov ax,val1				;ASSUME�Ѿ�ʹ�ö�data1
	mov bx,es:val2				;ASSUME�Ѿ�ʹ�ö�data2
	mov ax,4C00h
	int 21h
main ENDP
cseg ENDS

data1 SEGMENT 'DATA'
	val1 WORD 1001h
data1 ENDS

data2 SEGMENT 'DATA'
	val2 WORD 1002h
data2 ENDS

mystack SEGMENT para STACK 'STACK'
	BYTE 100h DUP('S')
mystack ENDS

END main 