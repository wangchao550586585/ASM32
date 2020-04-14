;ģ������·
INCLUDE Irvine32.inc
WalkMax=50
StartX=25
StartY=25
DrunkardWalk STRUCT
	path COORD WalkMax DUP(<0,0>)
	pathsUsed WORD 0
DrunkardWalk ENDS

DisplayPosition PROTO currX:WORD,currY:WORD
.data
aWalk DrunkardWalk<>
.code
main PROC
	mov esi,OFFSET aWalk
	call TakeDrunkenWalk
	exit
main ENDP

TakeDrunkenWalk PROC
	LOCAL currX:WORD,currY:WORD
	pushad
	mov edi,esi
	add edi,OFFSET DrunkardWalk.path

	mov edi,OFFSET DrunkardWalk.path
	mov edi,OFFSET aWalk
	mov edi,OFFSET aWalk.DrunkardWalk
	mov edi,OFFSET aWalk.DrunkardWalk.path


	mov ecx,WalkMax
	mov currX,StartX
	mov currY,StartY
Again:
	mov ax,currX
	mov (COORD PTR [edi]).X,ax
	mov ax,currY
	mov (COORD PTR [edi]).Y,ax
	INVOKE DisplayPosition,currX,currY
	mov eax,4
	call RandomRange
	.IF eax==0
		dec currY
	.ELSEIF eax==1
		inc currY
	.ELSEIF eax==2
		dec currX
	.ELSE
		inc currX
	.ENDIF
	add edi,TYPE COORD
	loop Again

Finish:
	mov (DrunkardWalk PTR [esi]).pathsUsed,WalkMax
	popad
	ret
TakeDrunkenWalk ENDP

DisplayPosition PROC currX:WORD,currY:WORD
	.data
	commaStr BYTE ",",0
	.code
	pushad
		movzx eax,currX
		call WriteDec
		mov edx,OFFSET commaStr
		call WriteString
		movzx eax,currY
		call WriteDec
		call Crlf
	popad
	ret
DisplayPosition ENDP
END main