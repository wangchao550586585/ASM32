;���ù��λ��
;Y����(DH)0~24֮��
;X����(DL)0~79֮��
SetCursorPosition PROC
.data
BadXCoordMsg BYTE "X-Coordinate out of range!",0Dh,0Ah,0
BadYCoordMsg BYTE "Y-Coordinate out of range!",0Dh,0Ah,0
.code
	.IF(DL<0)||(DL>79)
		mov edx,OFFSET BadXCoordMsg
		call WriteString
		jmp quit
	.ENDIF
	.IF(DH<0)||(DH>24)
		mov edx,OFFSET BadYCoordMsg
		call WriteString
		jmp quit
	.ENDIF
	call Gotoxy
quit:
	ret
SetCursorPosition ENDP

---------------------------------
INCLUDE Irvine32.inc
;��ѧ�γ�ע��

.data
TRUE=1
FALSE=0
gradeAverage WORD 275
credits		 WORD 12
OkToRegister BYTE ?

main PROC
.code 
	mov OkToRegister,FALSE
	.IF gradeAverage>350
		mov OkToRegister,TRUE
	.ELSEIF(gradeAverage>250)&&(credits<=16)
		mov OkToRegister,TRUE
	.ELSEIF(credits<=12)
		mov OkToRegister,TRUE
	.ENDIF
main ENDP
END main

