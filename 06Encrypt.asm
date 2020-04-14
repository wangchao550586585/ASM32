;字符串加密解密
;(X XOR Y)XOR Y=X
INCLUDE Irvine32.inc
KEY=239
BUFMAX=128
.data
sPrompt  BYTE "Enter the plain text: ",0
sEncrypt BYTE "Cipher text:         ",0
sDecrypt BYTE "Decrypted:           ",0
buffer   BYTE BUFMAX+1 DUP(0)
bufSize  DWORD ?

.code
main PROC
	call InputTheString				;输入明文
	call TranslateBuffer			;加密缓冲区
	mov edx,OFFSET sEncrypt			;显示加密的信息
	call DisplayMessage				
	call TranslateBuffer			;解密缓冲区
	mov edx,OFFSET sDecrypt			;显示解密消息
	call DisplayMessage
	exit
main ENDP

InputTheString PROC
	pushad
	mov edx,OFFSET sPrompt			;显示提示信息
	call WriteString				
	mov ecx,BUFMAX					;最多字符数目
	mov edx,OFFSET buffer			;指向缓冲区
	call ReadString					;输入字符串
	mov bufSize,eax					;保存其长度
	call Crlf
	popad
	ret
InputTheString ENDP

TranslateBuffer PROC
	pushad
	mov ecx,bufSize
	mov esi,0						;缓冲区的索引0

	L1:
	xor buffer[esi],KEY
	inc esi
	loop L1
	popad
	ret
TranslateBuffer ENDP

DisplayMessage PROC
	pushad
	call WriteString
	mov edx,OFFSET buffer
	call WriteString
	call Crlf
	call Crlf
	popad
	ret
DisplayMessage ENDP
END main