;����2�ε���GetTickCount֮�侭����ʱ��,�����ʱ�������ֵ�Ƿ����˻ع�(����49.7��)
INCLUDE Irvine32.inc
INCLUDE macros.inc
.data
startTime DWORD ?
.code
main PROC
	INVOKE GetTickCount
	mov startTime,eax

	mov ecx,10000100h
L1:
	imul ebx
	imul ebx
	imul ebx
	loop L1
	INVOKE GetTickCount
	cmp eax,startTime		
	jb error				;С����ʼʱ��,ʱ��ع���
	sub eax,startTime
	call WriteDec
	mWrite <"����ֵ",0dh,0ah>
	jmp quit
error:
	mWrite "��ȡʱ����Ч"
	mWrite <"ʱ�䳬����49.7��",0dh,0ah>
quit:
	exit
main ENDP
END main 
