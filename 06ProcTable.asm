;��������ķ�֧ѡ��,�������·ѡ��ṹ��һ�ַ���
;����һ����������ֵ�͹���ƫ�Ƶı��,����ʹ��ѭ�����������
INCLUDE Irvine32.inc
.data
CaseTable BYTE 'A'				;����ֵ
		  DWORD Process_A		;���̵ĵ�ַ
EntrySize=($-CaseTable)			;�ɻ������Ԥ����׶��滻Ϊ��Ӧ���ʽ��ֵ
		  BYTE 'B'
		  DWORD Process_B
		  BYTE 'C'
		  DWORD Process_C
		  BYTE 'D'
		  DWORD Process_D
NumberOfEntries=($-CaseTable)/EntrySize
prompt BYTE "Press capital A,B,C or D: ",0

;Ϊÿ�����̶���һ����Ϣ�ַ���
msgA BYTE "Process_A",0
msgB BYTE "Process_B",0
msgC BYTE "Process_C",0   
msgD BYTE "Process_D",0

.code
main PROC
	mov edx,OFFSET prompt
	call WriteString
	call ReadChar				;��ȡ�ַ���AL
	mov ebx,OFFSET CaseTable	;ָ����
	mov ecx,NumberOfEntries		
 
 L1:cmp al,[ebx]
    jne L2
	call NEAR PTR [ebx+1]
	call WriteString
	call Crlf
	jmp L3
 
 L2:add ebx,EntrySize
	loop L1

 L3:exit
main ENDP
Process_A PROC
	mov edx,OFFSET msgA
	ret
Process_A ENDP
Process_B PROC
	mov edx,OFFSET msgB
	ret
Process_B ENDP
Process_C PROC
	mov edx,OFFSET msgC
	ret
Process_C ENDP
Process_D PROC
	mov edx,OFFSET msgD
	ret
Process_D ENDP

END main
