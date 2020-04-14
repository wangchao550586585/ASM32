INCLUDE Irvine32.inc

EXTERN PromptForIntegers@0:PROC
EXTERN ArraySum@0:PROC,DisplaySum@0:PROC

ArraySum			EQU ArraySum@0
PromptForIntegers	EQU PromptForIntegers@0
DisplaySum			EQU DisplaySum@0

Count=3

.data
prompt1 BYTE "Enter a signed integer: ",0
prompt2 BYTE "The sum of the integer is : ",0
array	DWORD Count DUP(?)
sum		DWORD ?

.code
main PROC
	call Clrscr
	
	push Count
	push OFFSET array
	push OFFSET prompt1
	call PromptForIntegers

	push Count
	push OFFSET array
	call ArraySum
	mov sum,eax

	push sum
	push OFFSET prompt2
	call DisplaySum
	
	call Crlf
	exit
main ENDP
END main 