INCLUDE Irvine32.inc
INCLUDE Macros.inc
.code
main PROC
L1:	mov eax,10
	call Delay
	call ReadKey
	jz L1
	test ebx,CAPSLOCK_ON			;CAPSLOCK_ON:¼üÅÌ¿ØÖÆ¼üµÄ×´Ì¬Öµ
	jz L2
	mWrite <"CapsLock is ON",0dh,0ah>
	jmp L3
L2:	mWrite <"CapsLock is OFF",0dh,0ah>
L3:	exit		
main ENDP
END main 