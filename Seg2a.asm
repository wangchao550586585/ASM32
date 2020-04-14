PUBLIC subroutine_1,var2
cseg SEGMENT BYTE PUBLIC 'CODE'
ASSUME cs:cseg,ds:dseg

subroutine_1 PROC
	mov ah,9
	mov dx,OFFSET msg
	int 21h
	ret
subroutine_1 ENDP
cseg ENDS

dseg SEGMENT WORD PUBLIC 'DATA'
	var2 WORD 2000h
	msg BYTE 'Now in Subroutine_1'
		BYTE 0Dh,0Ah,'$'
dseg ENDS
ENDS
