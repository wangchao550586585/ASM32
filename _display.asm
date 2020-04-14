INCLUDE Irvine32.inc
.code
DisplaySum PROC
	theSum EQU [ebp+12]
	ptrPrompt EQU [ebp+8]
	enter 0,0
	push eax
	push edx
	
	mov edx,ptrPrompt
	call WriteString
	mov eax,theSum
	call WriteInt
	call Crlf

	pop edx
	pop eax
	leave
	ret 8
DisplaySum ENDP
END
