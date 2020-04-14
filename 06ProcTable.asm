;表格驱动的分支选择,是替代多路选择结构的一种方法
;创建一个包含查找值和过程偏移的表格,程序使用循环来搜索表格
INCLUDE Irvine32.inc
.data
CaseTable BYTE 'A'				;查找值
		  DWORD Process_A		;过程的地址
EntrySize=($-CaseTable)			;由汇编器在预处理阶段替换为对应表达式的值
		  BYTE 'B'
		  DWORD Process_B
		  BYTE 'C'
		  DWORD Process_C
		  BYTE 'D'
		  DWORD Process_D
NumberOfEntries=($-CaseTable)/EntrySize
prompt BYTE "Press capital A,B,C or D: ",0

;为每个过程定义一个消息字符串
msgA BYTE "Process_A",0
msgB BYTE "Process_B",0
msgC BYTE "Process_C",0   
msgD BYTE "Process_D",0

.code
main PROC
	mov edx,OFFSET prompt
	call WriteString
	call ReadChar				;读取字符到AL
	mov ebx,OFFSET CaseTable	;指向表格
	mov ecx,NumberOfEntries		
 
 L1:cmp al,[ebx]
    jne L2
	call NEAR PTR [ebx+1]
	call WriteString
	call Crlf
	jmp L3
 
 L2:add ebx,EntrySize
	loop L1

 L3:exit
main ENDP
Process_A PROC
	mov edx,OFFSET msgA
	ret
Process_A ENDP
Process_B PROC
	mov edx,OFFSET msgB
	ret
Process_B ENDP
Process_C PROC
	mov edx,OFFSET msgC
	ret
Process_C ENDP
Process_D PROC
	mov edx,OFFSET msgD
	ret
Process_D ENDP

END main
