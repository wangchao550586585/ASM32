TITLE Add and Subtract	;TITLEαָ����б�Ϊע��
;������Ӽ�
INCLUDE Irvine32.inc	;INCLUDEαָ���Irvine32.inc�ļ��и��Ʊ���Ķ����������Ϣ
.code			;αָ���Ǵ���εĿ�ʼ
main1 PROC		;PROCαָ���ʶһ�����̵Ŀ�ʼ,������Ϊmain
	mov eax,10000h
	add eax,40000h
	sub eax,20000h
	call DumpRegs	;����һ����ʾCPU�Ĵ���ֵ�Ĺ���
	exit		;����һ��Ԥ�����MS-WINDOWS��������ֹ����
main1 ENDP		;ENDPαָ����main���̵Ľ���
END main1		;ENDαָ���ע�����ǻ��Դ�������һ��,����������Ժ������������,main�ǳ�����ڵ���