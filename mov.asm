INCLUDE Irvine32.inc	
.data
val1 WORD 1000h
val2 WORD 2000h
arrayB BYTE 10h,20h,30h,40h,50h
arrayW WORD 100h,200h,300h
arrayD DWORD 10000h,20000h

.code
mainMov PROC
	;MOVZX
	mov bx,0A69Bh
	movzx eax,bx
	movzx edx,bl
	movzx cx,bl

	;MOVSX
	mov bx,0A69Bh
	movsx eax,bx
	movsx edx,bl
	mov bl,7Bh
	movsx cx,bl

	;内存到内存的交换
	mov ax,val1
	xchg ax,val2
	mov val1,ax

	;直接偏移寻址
	mov al,arrayB
	mov al,[arrayB+1]
	mov al,arrayB+1
	exit
mainMov ENDP
END mainMov