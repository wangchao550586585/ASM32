;ѭ����������
INCLUDE Irvine32.inc


COORD STRUCT
  X WORD ?
  Y WORD ?
COORD ENDS

Numpoints=3
.data
ALIGN WORD
AllPoints COORD Numpoints DUP(<0,0>)
COORD STRUCT
  X WORD ?
  Y WORD ?
COORD ENDS
.code
main PROC
	mov edi,0
	mov ecx,Numpoints
	mov ax,1			;��ʼ��X��Y����ֵ
L1:	mov (COORD PTR AllPoints[edi]).X,ax
	mov (COORD PTR AllPoints[edi]).Y,ax
	mov ax,AllPoints[edi].X
	mov ax, [AllPoints+edi].Y

	add edi,TYPE COORD
	inc ax
	loop L1

	exit
main ENDP
END main