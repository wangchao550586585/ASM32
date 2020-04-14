;阻止按ctrl-alt-delete重启系统,只能通过ctrl-alt-右shift-del
.model tiny
.386
.code
	rt_shift	EQU		01h		;右shift:在键盘状态标志字节第0位
	ctrl_key	EQU		04h		;ctrl键:位2
	alt_key		EQU		08h		;alt键:位3
	del_key		EQU		53h		;del键的扫描码
	kybd_port	EQU		60h		;键盘输入端口
	ORG	100h					;这是一个COM程序
start:
	jmp setup					;跳转到TSR(内存驻留程序)安装部分
int9_handler PROC FAR
	sti							;允许硬件中断
	pushf						
	push es
	push ax
	push di

;复制键盘标志到AH
L1:	mov ax,40h
	mov es,ax
	mov di,17h
	mov ah,es:[di]

;测试ctrl和alt
L2:	test ah,ctrl_key
	jz L5
	test ah,alt_key
	jz L5

;测试Del和右shift键
L3:	in al,kybd_port
	cmp al,del_key
	jne L5
	test ah,rt_shift		;重启
	jnz L5

L4:	and ah,NOT ctrl_key		;只有在同时按下右Shift时才允许用户重启,否则程序清除ctrl位,有效阻止了用户试图重启机器的企图
	mov es:[di],ah			;恢复键盘标志
L5:	pop di
	pop ax
	pop es
	popf
	jmp cs:[old_interrupt9]
old_interrupt9 DWORD ?
int9_handler ENDP

end_ISR label BYTE

setup:
	mov ax,3509h						;获取int9中继向量
	int 21h
	mov word ptr old_interrupt9,bx		;保存原int9中继向量
	mov word ptr old_interrupt9+2,es
	
	mov ax,2509h						;设置INT9中继向量
	mov dx,offset int9_handler
	int 21h

	;int21h-32h返回到MS-DOS,并把驻留部分留在内存中,该功能自动保留从PSP开始-DX中指定的偏移处的所有内容
	mov ax,3100h						;终止并驻留
	mov dx,OFFSET end_ISR				;指向驻留代码的末尾
	shr	dx,4							;除以16
	inc dx								;向上按节近似取整
	int 21h								;执行MS-DOS功能调用
END start

