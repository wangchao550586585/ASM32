;不同模块源代码,也可以组合在同一个段中,只要对不同模块内的段使用同样的名字并全部指定PUBLCI组合方式即可.
;2个程序模块,2代码段,数据段和一个堆栈段,最后组合成3个段CSEG,DSEG,SSEG
;CSEG,DSEG使用PUBLIC组合方式
;CSEG段使用BYTE对齐方式,避免在2个代码段连接时候出现空隙

EXTRN var2:WORD
EXTERN subroutine_1:PROC

cseg SEGMENT BYTE PUBLIC 'CODE'
ASSUME cs:cseg,ds:dseg,ss:sseg
main PROC
	mov ax,dseg
	mov ds,ax
	mov ax,var1
	mov bx,var2
	call subroutine_1
	mov ax,4C00h
	int 21h
main ENDP
cseg ENDS

dseg SEGMENT WORD PUBLIC 'DATA'
	var1 WORD 1000h
dseg ENDS

sseg SEGMENT STACK 'STACK'
	BYTE 100h dup('S')
sseg ENDS

END main 