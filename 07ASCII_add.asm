;ASCII��������2��С�������ӷ�����
INCLUDE Irvine32.inc
DECIMAL_OFFSET=5
.data
decimal_one BYTE "100123456789765"	;1001234567.89765
decimal_two BYTE "900402076502015"	;9004020765.02015
sum BYTE (SIZEOF decimal_one+1) DUP(0),0
.code
main PROC
	mov esi,SIZEOF decimal_one-1
	mov edi,SIZEOF decimal_one
	mov ecx,SIZEOF decimal_one
	mov bh,0

L1: mov ah,0		;���AH
	mov al,decimal_one[esi]
	add al,bh
	aaa				;AH=carry,10���Ʊ�ʾ
	mov bh,ah
	or bh,30h		;bh=carry,ASCII��ʾ
	add al,decimal_two[esi]
	aaa
	or bh,ah		;2�����ֻ����һ��
	or bh,30h		;conver it to ASCII
	or al,30h		
	mov sum[edi],al
	dec esi
	dec edi
	loop L1
	mov sum[edi],bh

	;Display
	mov edx,OFFSET sum
	call WriteString
	call Crlf
	exit
main ENDP
END main