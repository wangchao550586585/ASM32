INCLUDE Irvine32.inc
EXTERN sub1@:PROC		;sub1@n:过程名和n表示的参数使用的总堆栈空间,4的倍数
.code
main PROC
	call sub1@
	exit
main ENDP
END main

变量和符号默认对于其所在模块私有
PUBLIC count,SYM1		;使用public导出特定名字
SYM1=10
.data
count DWORD 0

访问外部变量和符号
EXTERN name:type,对于符号(EQU,=定义)而言,type是ABS,对于变量,type是数据定义属性,如BYTE,DWORD以及PTR
EXTERN one:WORD,three:PTR BYTE,four:ABS

EXTERNDEF:可替代PUBLIC和EXTERN
1:定义一个vars.inc文件
EXTERN count:DWORD,SYM1:ABS
2:创建sub1.asm,该文件包含count和SYM1的定义,由于不是程序启动模块,END省略程序入口标号
.386
.model flat,STDCALL
INCLUDE vars.inc
SYM1=10
.data
count DWORD 0
END
3:main文件,INCLUDE vars.inc,可直接使用count,SYM1

