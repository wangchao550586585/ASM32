;����Irvine32���ӿ��е���������ɹ���
INCLUDE Irvine32.inc
TAB=9		;TAB��ASCII��
.code
main PROC
	call Randomize	;��ʼ�������������
	call Rand1
	call Rand2
	exit 
main ENDP

Rand1 PROC
	;����10��α�����
	mov ecx,10			
 L1:call Random32			;���������
	call WriteDec			;���޷���ʮ��������ʽ��ʾ
	mov al,TAB				;ˮƽ�Ʊ��
	call WriteChar			;��ʾˮƽ�Ʊ��
	loop L1
	call Crlf
	ret
Rand1 ENDP

Rand2 PROC
	;����10���ڷ�Χ-50~49֮���α�����
		mov ecx,10
	L1: mov eax,100
		call RandomRange
		sub eax,50
		call WriteInt
		mov al,TAB
		call WriteChar
		loop L1
		call Crlf
		ret
Rand2 ENDP

END main
