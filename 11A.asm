;¥Ú”°ErrorMessage
.data
messageId DWORD ?
pErrorMsg DWORD ?
.code
call GetLastError
mov messageId,eax
INVOKE FormatMessage,FORMAT_MESSAGE_ALLOCATE_BUFFER+FORMAT_MESSAGE_FROM_SYSTEM,NULL,messageID,0,ADDR pErrorMsg,0,NULL
INVOKE LocalFree,pErrormsg			; Õ∑≈pErrormsgƒ⁄¥Ê
