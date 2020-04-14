;使用CMPSB+REPE比较2字符串差异,2字符串需长度一致
;找到后ESI和EDI将指向2个字符串不同的后面的一个位置,如果是相同的,将指向结尾的后一个位置
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