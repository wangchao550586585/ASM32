;调用MessageBoxA函数,在win32程序中产生输出
INCLUDE Irvine32.inc
.data
captionW	BYTE	"Attempt to Divide by Zero",0
warningMsg	BYTE	"Please check your denominator.",0
captionQ	BYTE	"Question",0
questionMsg	BYTE	"Do you want to know my name?",0
showMyName	BYTE	"My name is MASM",0dh,0ah,0
captionC	BYTE	"Information",0
infoMsg		BYTE	"Your file was erased.",0dh,0ah
			BYTE	"Notify system admin,or restore backup?",0

.code
main PROC
	;窗口句柄(设NULL表示消息框没有所有者),消息框内字符串,对话框标题字符串,内容和行为类型
	INVOKE MessageBox,NULL,ADDR warningMsg,ADDR captionW,MB_OK+MB_ICONEXCLAMATION
	INVOKE MessageBox,NULL,ADDR questionMsg,ADDR captionQ,MB_YESNO+MB_ICONQUESTION
	cmp eax,IDYES
	jne	L2
	mov edx,OFFSET showMyName
	call WriteString
L2:	INVOKE MessageBox,NULL,ADDR infoMsg,ADDR captionC,MB_YESNOCANCEL+MB_ICONEXCLAMATION+MB_DEFBUTTON2
	exit

main ENDP
END main 
