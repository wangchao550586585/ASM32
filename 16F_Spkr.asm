;扬声器通过61端口开启关闭
	;开启:读取61端口值最低二位置位
	;关闭:清零输出即可
;Intel8253定时器控制芯片控制产生声音的频率:向45端口发送0~255值
INCLUDE Irvine16.inc
speaker EQU 61h				;扬声器端口地址
timer	EQU 42h				;定时器端口地址
delay1	EQU 500
delay2	EQU 0D000h			;音符之间的延时
.code
main PROC	
	in al,speaker			;获取扬声器状态
	push ax					;保存状态
	or al,00000011b			;低二位置位
	out speaker,al			;打开扬声器
	mov al,60				;起始频率
L2:	out timer,al			;输出脉冲频率到定时器端口
	;频率改变前创建一个循环
	mov cx,delay1
L3:	push cx				;外循环
	mov cx,delay2		;内循环
L3a:
	loop L3a
	pop cx
	loop L3
	
	sub al,1			;提高频率
	jnz L2				;演奏下一个音符
	
	pop ax				;获取初始状态
	and al,11111100b	;清除最低2位
	out speaker,al		;关闭扬声器
	exit
main ENDP
END main 