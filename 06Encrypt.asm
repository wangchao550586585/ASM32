;�ַ������ܽ���
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
	call InputTheString				;��������
	call TranslateBuffer			;���ܻ�����
	mov edx,OFFSET sEncrypt			;��ʾ���ܵ���Ϣ
	call DisplayMessage				
	call TranslateBuffer			;���ܻ�����
	mov edx,OFFSET sDecrypt			;��ʾ������Ϣ
	call DisplayMessage
	exit
main ENDP

InputTheString PROC
	pushad
	mov edx,OFFSET sPrompt			;��ʾ��ʾ��Ϣ
	call WriteString				
	mov ecx,BUFMAX					;����ַ���Ŀ
	mov edx,OFFSET buffer			;ָ�򻺳���
	call ReadString					;�����ַ���
	mov bufSize,eax					;�����䳤��
	call Crlf
	popad
	ret
InputTheString ENDP

TranslateBuffer PROC
	pushad
	mov ecx,bufSize
	mov esi,0						;������������0

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