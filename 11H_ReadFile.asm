INCLUDE Irvine32.inc
INCLUDE macros.inc
BUFFER_SIZE=5000

.data
buffer BYTE BUFFER_SIZE DUP(?)
filename BYTE 80 DUP(0)
fileHandle	HANDLE ?
.code
main PROC
	mWrite "Enter an input filename: "
	mov edx,OFFSET filename
	mov ecx,SIZEOF filename
	call ReadString

	mov edx,OFFSET filename
	call OpenInputFile
	mov fileHandle,eax

	cmp eax,INVALID_HANDLE_VALUE
	jne file_ok
	mWrite <"Cannot open file",0dh,0ah>
	jmp quit
file_ok:
	mov edx,OFFSET buffer
	mov ecx,BUFFER_SIZE
	call ReadFromFile
	jnc check_buffer_size		
	mWrite "Error reading file. "
	call WriteWindowsMsg
	jmp close_file
check_buffer_size:
	cmp eax,BUFFER_SIZE
	jb buf_size_ok
	mWrite <"Error:Buffer too small for the file",0dh,0ah>
	jmp quit
buf_size_ok:
	mov buffer[eax],0
	mWrite "File size: "
	call WriteDec
	call Crlf
	mWrite <"Buffer:",0dh,0ah,0dh,0ah>
	mov edx,OFFSET buffer
	call WriteString
	call Crlf
close_file:
	mov eax,fileHandle
	call CloseFile
quit:
	exit

main ENDP
END main 