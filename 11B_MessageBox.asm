;����MessageBoxA����,��win32�����в������
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
	;���ھ��(��NULL��ʾ��Ϣ��û��������),��Ϣ�����ַ���,�Ի�������ַ���,���ݺ���Ϊ����
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
