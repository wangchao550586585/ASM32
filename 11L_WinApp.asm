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
	;获取当前进程的句柄
	INVOKE GetModuleHandle,NULL
	mov MainWin.hInstance,eax

	;加载程序的光标和图标
	INVOKE LoadIcon,NULL,IDI_APPLICATION
	mov MainWin.hIcon,eax
	INVOKE LoadCursor,NULL,IDC_ARROW
	mov MainWin.hCursor,eax

	;注册窗口类
	INVOKE RegisterClass,ADDR MainWin
	.IF eax==0
		call ErrorHandler
		jmp Exit_Program
	.ENDIF

	;创建应用程序的主窗口
	INVOKE CreateWindowEx,0,ADDR className,ADDR WindowName,MAIN_WINDOW_STYLE,CW_USEDEFAULT,CW_USEDEFAULT,CW_USEDEFAULT,
			CW_USEDEFAULT,NULL,NULL,hInstance,NULL
	;如果CreateWindowEx失败,显示一条消息退出
	.IF eax==0
		call ErrorHandler
		jmp Exit_Program
	.ENDIF

	;保存窗口句柄,显示并绘制窗口
	mov hMainWnd,eax
	INVOKE ShowWindow,hMainWnd,SW_SHOW
	INVOKE UpdateWindow,hMainWnd

	;显示欢迎消息
	INVOKE MessageBox,hMainWnd,ADDR GreetText,ADDR GreetTitle,MB_OK

	;开始程序的持续消息处理循环
Message_Loop:
	INVOKE GetMessage,ADDR msg,NULL,NULL,NULL
	;无消息则退出
	.IF eax==0
		jmp Exit_Program
	.ENDIF

	;把消息转发给程序的WinProc过程
	INVOKE DispatchMessage,ADDR msg
	jmp Message_Loop

Exit_Program:
	INVOKE ExitProcess,0
WinMain ENDP

WinProc PROC,
	hWnd:DWORD,localMsg:DWORD,wParam:DWORD,lParam:DWORD
	mov eax,localMsg
	.IF eax==WM_LBUTTONDOWN				;鼠标按键消息?
		INVOKE MessageBox,hWnd,ADDR PopupText,ADDR PopupTitle,MB_OK
		jmp WinProcExit
	.ELSEIF eax==WM_CREATE
		INVOKE MessageBox,hWnd,ADDR AppLoadMsgText,ADDR AppLoadMsgTitle,MB_OK
		jmp WinProcExit
	.ELSEIF eax==WM_CLOSE				;关闭窗口消息?
		INVOKE MessageBox,hWnd,ADDR CloseMsg,ADDR WindowName,MB_OK
		INVOKE PostQuitMessage,0
		jmp WinProcExit	
	.ELSE								;其他消息?
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
		;获取对应的消息字符串
		INVOKE FormatMessage,FORMAT_MESSAGE_ALLOCATE_BUFFER+FORMAT_MESSAGE_FROM_SYSTEM,NULL,
			messageID,NULL,ADDR pErrorMsg,NULL,NULL
		;显示错误消息
		INVOKE MessageBox,NULL,pErrorMsg,ADDR ErrorTitle,MB_ICONERROR+MB_OK
		;释放消息字符串
		INVOKE LocalFree,pErrorMsg
		ret
ErrorHandler ENDP

END WinMain 

