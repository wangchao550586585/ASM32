INCLUDE Irvine32.inc
.code

DisplaySum PROC,
	ptrPrompt:PTR BYTE,
	theSum:DWORD

	push eax
	push edx
	
	mov edx,ptrPrompt
	call WriteString
	mov eax,theSum
	call WriteInt
	call Crlf

	pop edx
	pop eax
	ret
DisplaySum ENDP
END
