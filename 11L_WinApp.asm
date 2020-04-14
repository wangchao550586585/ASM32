INCLUDE Irvine32.inc
INCLUDE GraphWin.inc
.data
AppLoadMsgTitle	BYTE "Application Loaded",0
AppLoadMsgText	BYTE "This window display when the WM_CREATE "
				BYTE "message is received",0

PopupTitle		BYTE "Popup Window",0
PopupText		BYTE "This Window was activated by a "
				BYTE "WM_LBUTTONDOWN message",0
GreetTitle		BYTE "Main Window Active",0
GreetText		BYTE "This window is shown immediately after "
				BYTE "CreateWindow and UpdateWindow are called.",0

CloseMsg		BYTE "WM_CLOSE message received",0

ErrorTitle		BYTE "Error",0
WindowName		BYTE "ASM Windows App",0
className		BYTE "ASMWin",0

MainWin			WNDCLASS <NULL,WinProc,NULL,NULL,NULL,NULL,NULL,COLOR_WINDOW,NULL,className>

msg				MSGStruct <>
winRect			RECT <>
hMainWnd		DWORD ?
hInstance		DWORD ?

.code
WinMain PROC
	;��ȡ��ǰ���̵ľ��
	INVOKE GetModuleHandle,NULL
	mov MainWin.hInstance,eax

	;���س���Ĺ���ͼ��
	INVOKE LoadIcon,NULL,IDI_APPLICATION
	mov MainWin.hIcon,eax
	INVOKE LoadCursor,NULL,IDC_ARROW
	mov MainWin.hCursor,eax

	;ע�ᴰ����
	INVOKE RegisterClass,ADDR MainWin
	.IF eax==0
		call ErrorHandler
		jmp Exit_Program
	.ENDIF

	;����Ӧ�ó����������
	INVOKE CreateWindowEx,0,ADDR className,ADDR WindowName,MAIN_WINDOW_STYLE,CW_USEDEFAULT,CW_USEDEFAULT,CW_USEDEFAULT,
			CW_USEDEFAULT,NULL,NULL,hInstance,NULL
	;���CreateWindowExʧ��,��ʾһ����Ϣ�˳�
	.IF eax==0
		call ErrorHandler
		jmp Exit_Program
	.ENDIF

	;���洰�ھ��,��ʾ�����ƴ���
	mov hMainWnd,eax
	INVOKE ShowWindow,hMainWnd,SW_SHOW
	INVOKE UpdateWindow,hMainWnd

	;��ʾ��ӭ��Ϣ
	INVOKE MessageBox,hMainWnd,ADDR GreetText,ADDR GreetTitle,MB_OK

	;��ʼ����ĳ�����Ϣ����ѭ��
Message_Loop:
	INVOKE GetMessage,ADDR msg,NULL,NULL,NULL
	;����Ϣ���˳�
	.IF eax==0
		jmp Exit_Program
	.ENDIF

	;����Ϣת���������WinProc����
	INVOKE DispatchMessage,ADDR msg
	jmp Message_Loop

Exit_Program:
	INVOKE ExitProcess,0
WinMain ENDP

WinProc PROC,
	hWnd:DWORD,localMsg:DWORD,wParam:DWORD,lParam:DWORD
	mov eax,localMsg
	.IF eax==WM_LBUTTONDOWN				;��갴����Ϣ?
		INVOKE MessageBox,hWnd,ADDR PopupText,ADDR PopupTitle,MB_OK
		jmp WinProcExit
	.ELSEIF eax==WM_CREATE
		INVOKE MessageBox,hWnd,ADDR AppLoadMsgText,ADDR AppLoadMsgTitle,MB_OK
		jmp WinProcExit
	.ELSEIF eax==WM_CLOSE				;�رմ�����Ϣ?
		INVOKE MessageBox,hWnd,ADDR CloseMsg,ADDR WindowName,MB_OK
		INVOKE PostQuitMessage,0
		jmp WinProcExit	
	.ELSE								;������Ϣ?
		INVOKE DefWindowProc,hWnd,localMsg,wParam,lParam
		jmp WinProcExit
	.ENDIF
	WinProcExit:ret
WinProc ENDP

ErrorHandler PROC
		.data
		pErrorMsg DWORD ?
		messageID DWORD ?
		.code
		INVOKE GetLastError
		mov messageID,eax
		;��ȡ��Ӧ����Ϣ�ַ���
		INVOKE FormatMessage,FORMAT_MESSAGE_ALLOCATE_BUFFER+FORMAT_MESSAGE_FROM_SYSTEM,NULL,
			messageID,NULL,ADDR pErrorMsg,NULL,NULL
		;��ʾ������Ϣ
		INVOKE MessageBox,NULL,pErrorMsg,ADDR ErrorTitle,MB_ICONERROR+MB_OK
		;�ͷ���Ϣ�ַ���
		INVOKE LocalFree,pErrorMsg
		ret
ErrorHandler ENDP

END WinMain 

