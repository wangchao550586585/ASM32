;ʹ��CMPSB+REPE�Ƚ�2�ַ�������,2�ַ����賤��һ��
;�ҵ���ESI��EDI��ָ��2���ַ�����ͬ�ĺ����һ��λ��,�������ͬ��,��ָ���β�ĺ�һ��λ��
INCLUDE Irvine32.inc
.data
source	BYTE "MARTIN  "
dest	BYTE "MARTINE2"
str1	BYTE "Source is smaller",0dh,0ah,0
str2	BYTE "Source is not smaller",0dh,0ah,0
.code
main PROC
	cld
	mov esi,OFFSET source
	mov edi,OFFSET dest
	mov cx,LENGTHOF source
	repe cmpsb
	jb source_smaller
	mov edx,OFFSET str2
	jmp done
source_smaller:
	mov edx,OFFSET str1
done:
	call WriteString
	exit
main ENDP
END main