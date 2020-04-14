;安装CTRL-Break中继处理例程
INCLUDE Irvine16.inc
.data
breakMsg BYTE "BREAK",0
msg	BYTE "Ctrl-Break demonstration."
	BYTE  0dh,0ah
	BYTE "This program disables Ctrl-Break (Ctrl-C). Press any"
	BYTE  0dh,0ah
	BYTE "keys to continue, or press ESC to end the program."
	BYTE  0dh,0ah,0
.code
main PROC
	mov ax,@data
	mov ds,ax
	mov dx,OFFSET msg
	call WriteString

install_handler;
	push ds
	mov ax,@code
	mov ds,ax					
	mov ah,25h					;允许用新的中继处理过程地址替换原来的中断处理过程
	;程序结束时不必恢复INT23h中继向量,因为MS-DOS在程序结束时自动恢复int23h中断向量,MS-DOS把原始的INT23h存储在段前缀偏移000Eh处
	mov al,23h					;处理的中继向量号
	mov dx,OFFSET break_handler	;DS:DX新的CTRL-BREAK处理程序的段-偏移地址
	int 21h						
	pop ds

	;等待按键并回显
L1:	mov ah,1
	int 21h
	cmp al,18h
	jnz L1
	exit
main ENDP

;按下ctrl-break执行
break_handler PROC
	push ax
	push dx
	mov dx,OFFSET breakMsg
	call WriteString
	pop dx
	pop ax
	iret
break_handler ENDP
END main 