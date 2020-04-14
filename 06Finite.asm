;�����з�������������״̬��
;---��ʼ--->A---- +/- ---->B---����--->C<------|
;           |                         �� ��  ����
;           |--------����-------------|  |-----|

INCLUDE Irvine32.inc
ENTRY_KEY=13
.data
InvalidInputMsg BYTE "Invalid input",13,10,0
.code
main PROC
	call Clrscr

StateA:
	call Getnext			;��ȡ��һ���ַ���AL
	cmp al,'+'
	je StateB
	cmp al,'-'
	je StateB
	call IsDigit			;���AL�а���һ������,ZF=1
	jz StateC
	call DisplayErrorMsg	;������Ч���
	jmp Quit

StateB:
	call Getnext
	call IsDigit
	jz StateC
	call DisplayErrorMsg
	jmp Quit
StateC:
	call Getnext
	call IsDigit
	jz StateC
	cmp al,ENTRY_KEY
	je Quit
	call DisplayErrorMsg
	jmp Quit
Quit:
	call Crlf
	exit
main ENDP

Getnext PROC
	call ReadChar
	call WriteChar
	ret
Getnext ENDP

DisplayErrorMsg PROC
	push edx
	mov edx,OFFSET InvalidInputMsg
	call WriteString
	pop edx
	ret
DisplayErrorMsg ENDP

END main