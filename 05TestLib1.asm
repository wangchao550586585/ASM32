INCLUDE Irvine32.inc
.data
arrayD		DWORD 1000h,2000h,3000h
prompt1		BYTE "Enter a 32-bit signed integer: ",0
dwordVal	DWORD ?

.code
main PROC
		;ʹ��DumpMem������ʾ���������
		mov eax,yellow+(blue*16)
		call SetTextColor
		call Clrscr					;�����ɫ
		;�����ı���ɫΪ���׻���
		mov esi,OFFSET arrayD
		mov ecx,LENGTHOF arrayD
		mov ebx,TYPE arrayD
		call DumpMem
		call Crlf					;����

		;��ʾ�û�����һ��ʮ��������
		mov edx,OFFSET prompt1
		call WriteString
		call ReadInt
		mov dwordVal,eax

		;��ʮ/ʮ��/��������ʾ����
		call Crlf
		call WriteInt
		call Crlf
		call WriteHex
		call Crlf
		call WriteBin
		call Crlf
		call WaitMsg

		;������̨������ΪĬ����ɫ
		mov eax,lightGray+(black*16)
		call SetTextColor
		call Clrscr					;�����Ļ
		exit
main ENDP
END main