Example PROC
	push 5
	push 6
	call AddTwo
	add esp,8	;�Ӷ�ջ���Ƴ�5,6,������֤���ص�ַ��ȷ
	ret
Example ENDP

---------------
AddTwo PROC
	push ebp
	mov ebp,esp
	add eax,[ebp+12]
	add eax,[ebp+8]
	pop ebp
	ret 8			;�����ջ
AddTwo ENDP

-------------------
MySub PROC
	push ebp
	mov ebp,esp
	sub esp,8				
	mov DWORD PTR[ebp-4],10
	mvo DWORD PTR[ebp-8],20
	mov esp,ebp			;�൱�ڴӶ�ջ��ɾ���ֲ�����,
	pop ebp
	ret
MySub ENDP

-----------�ֲ���������
X_local EQU DWORD PTR [ebp-4]
Y_local EQU DWORD PTR [ebp-8]
MySub PROC
	push ebp
	mov ebp,esp
	sub esp,8				
	mov X_local,10
	mvo Y_local,20
	mov esp,ebp			
	pop ebp
	ret
MySub ENDP


-----------LEA
makeArray PROC
	push ebp
	mov ebp,esp
	sub esp,32			;��˫�ֱ߽����
	
	lea esi,[ebp-30]	;����ֻ��30�ֽ�,��̬�����ַ��ESI��OFFSETֻ�ܻ�ȡ�ڱ���ʱ��֪�ĵ�ַ
	mov ecx,30

L1:	mov BYTE PTR [esi],'*'
	inc	esi
	loop L1
	
	add esp,32
	pop ebp
	ret
makeArray ENDP

----------ENTER/LEAVE
MySub PROC
	enter,8,0
	
	leave
	ret

MySub PROC
	push ebp
	mov ebp,esp
	sub esp,8			

	mov esp,ebp
	pop ebp

----------LOCAL
LOCAL pArray:PTR WORD			;PTR WORDָ��һ��16λ�����ľֲ�����
LOCAL TempArray[10]:DWORD		;����10��˫�ֵ�����
Example PROC
	LOCAL temp:DWORD
	mov eax,temp
	ret
Example ENDP
����Ϊ
push ebp
mov ebp,esp
add esp,0FFFFFFFCh
mov eax,[ebp-4]
leave
ret

-----------INVOKE
(����ʹ�õ���STDCALL���Թؼ���)
���ݲ���<32����λ,���ܵ���ѹջ֮ǰʹ��EAX/EDX�Բ���������չ
INVOKE DumpArray,OFFSET array,LENGTHOF array,TYPE array
�ȼ���
push TYPE array
push LENGTHOF array
push OFFSET array
call DumpArray

ADDR:����ָ�����,ֻ����INVOKE����,�����ڴ�ģʽ��ͬ,ADDR����Զ��ָ��,����ģʽADDR��OFFSET����32λƫ��ֵ
��ʽ:ADDR ���ʱ�ĳ���
	INVOKE DumpArray,ADDR array ,ADDR [array+4]  
		���ɴ��� 
		push OFFSET Array+4
		push OFFSET Array
		call DumpArray
	INVOKE DumpArray,ADDR [ebp+12] ;�����

----------PROC
��� PROC [����] [USES�Ĵ����б�],�����б�
�����б����ŷָ�,����ͨ���������ò���,������[EBP+8]
	������ʽ:������:����

AddTwo PROC,val1:DWORD,val2:DWORD
	mov eax,val1
	add eax,val2
	ret
AddTwo ENDP
����
AddTwo PROC
	push ebp
	mov ebp,esp
	mov eax,dword ptr [ebp+8]
	add eax,dword ptr [ebp+0Ch]
	leave 
	ret 8			;��ʹ��STDCALLԼ��ʱ,MASMΪRET���ɳ���������
AddTwo ENDP

����һ��ָ���ֽ������ָ��
FillArray PROC  STDCALL,		;���õ���Э��
			USES eax,ebx,
			pBuffer:PTR BYTE
			LOCAL fileHandle:DWORD

			mov esi,pBuffer
			mov fileHandle,eax

			ret
FillArray ENDP
����:
FillArray PROC
			push ebp
			mov ebp,esp

			add esp,0FFFFFFFCh
			push eax			;ѹջ֮ǰΪ��ջ�ϵľֲ����������ռ�
			push ebx
			mov esi,dword ptr [ebp+8]		;pBuffer
			mov dword ptr [ebp-4],eax

			pop ebx
			pop eax
			leave
			ret 4
FillArray ENDP

---------------PROTO
;Ϊһ���Ѵ��ڵĹ��̴���һ��ԭ��,�����˹��̵����ֺͲ����б�
;�������ڶ������֮ǰ�͵��øù��̲���֤����ʱ���ݵĲ�������Ŀ�Ƿ��붨����ƥ��
INVOKEҪ����õĹ�����һ�����ʵ�ԭ������,���̵�ʵ����INVOKE֮ǰ,PROC������ԭ������
����PROC,��PROC����ΪPROTO,ȥ��USES�Լ����Ĵ����б�
Eaxmple PROC C,parm1:DWORD
���ʵ�ʲ����ߴ�<�����Ĳ����ߴ�,MASM����չ�����������Ĵ�С mov al,byte ptr ds:[]/ movzx eax,al/push eax
���ADDR��������,push ADDR��ʾ�Ĳ�����ַ
���������ֽ�,mov al byte ptr ds:[]/ push eax
���������WORD,��sub esp,2/ push word ptr dr:[]


