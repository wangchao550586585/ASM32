;�û�����һ������,������*2,��ʾ�˻�,C++�����������
INCLUDE Irvine32.inc
askForInteger PROTO C
showInt PROTO C,value:SDWORD,outWidth:DWORD
OUT_WIDTH=8
ENDING_POWER=10
.data
intVal DWORD ?
.code
SetTextOutColor PROC C,
		color:DWORD
		mov eax,color
		call SetTextColor
		call Clrscr
		ret
SetTextOutColor ENDP

DisplayTable PROC C
	INVOKE askForInteger			;����C++����
	mov intVal,eax					;��������
	mov ecx,ENDING_POWER			;ѭ��������
L1:	push ecx						;C++���������ᱣ��/�ָ�ͨ�üĴ���,�����ﱣ��ecx	
	shl intVal,1					;*2
	INVOKE showInt,intVal,OUT_WIDTH
	
	;-----------����INVOKE
	;push OUT_WIDTH		;���չ涨���򴫲�
	;push intVal
	;call showInt
	;add esp,8			�����ջ

	pop ecx
	loop L1
	ret
DisplayTable ENDP
END