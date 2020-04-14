Example PROC
	push 5
	push 6
	call AddTwo
	add esp,8	;从堆栈中移除5,6,这样保证返回地址正确
	ret
Example ENDP

---------------
AddTwo PROC
	push ebp
	mov ebp,esp
	add eax,[ebp+12]
	add eax,[ebp+8]
	pop ebp
	ret 8			;清理堆栈
AddTwo ENDP

-------------------
MySub PROC
	push ebp
	mov ebp,esp
	sub esp,8				
	mov DWORD PTR[ebp-4],10
	mvo DWORD PTR[ebp-8],20
	mov esp,ebp			;相当于从堆栈中删除局部变量,
	pop ebp
	ret
MySub ENDP

-----------局部变量符号
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
	sub esp,32			;按双字边界对齐
	
	lea esi,[ebp-30]	;数组只有30字节,动态赋予地址给ESI，OFFSET只能获取在编译时已知的地址
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
LOCAL pArray:PTR WORD			;PTR WORD指向一个16位整数的局部变量
LOCAL TempArray[10]:DWORD		;声明10个双字的数组
Example PROC
	LOCAL temp:DWORD
	mov eax,temp
	ret
Example ENDP
解析为
push ebp
mov ebp,esp
add esp,0FFFFFFFCh
mov eax,[ebp-4]
leave
ret

-----------INVOKE
(假设使用的是STDCALL语言关键字)
传递参数<32数据位,可能导致压栈之前使用EAX/EDX对参数进行扩展
INVOKE DumpArray,OFFSET array,LENGTHOF array,TYPE array
等价与
push TYPE array
push LENGTHOF array
push OFFSET array
call DumpArray

ADDR:传递指针参数,只能与INVOKE连用,根据内存模式不同,ADDR返回远近指针,保护模式ADDR和OFFSET返回32位偏移值
格式:ADDR 汇编时的常量
	INVOKE DumpArray,ADDR array ,ADDR [array+4]  
		生成代码 
		push OFFSET Array+4
		push OFFSET Array
		call DumpArray
	INVOKE DumpArray,ADDR [ebp+12] ;错误的

----------PROC
标号 PROC [属性] [USES寄存器列表],参数列表
参数列表：逗号分隔,可以通过名字引用参数,而不是[EBP+8]
	参数格式:参数名:类型

AddTwo PROC,val1:DWORD,val2:DWORD
	mov eax,val1
	add eax,val2
	ret
AddTwo ENDP
汇编成
AddTwo PROC
	push ebp
	mov ebp,esp
	mov eax,dword ptr [ebp+8]
	add eax,dword ptr [ebp+0Ch]
	leave 
	ret 8			;当使用STDCALL约定时,MASM为RET生成常量操作数
AddTwo ENDP

接受一个指向字节数组的指针
FillArray PROC  STDCALL,		;设置调用协议
			USES eax,ebx,
			pBuffer:PTR BYTE
			LOCAL fileHandle:DWORD

			mov esi,pBuffer
			mov fileHandle,eax

			ret
FillArray ENDP
汇编成:
FillArray PROC
			push ebp
			mov ebp,esp

			add esp,0FFFFFFFCh
			push eax			;压栈之前为堆栈上的局部变量保留空间
			push ebx
			mov esi,dword ptr [ebp+8]		;pBuffer
			mov dword ptr [ebp-4],eax

			pop ebx
			pop eax
			leave
			ret 4
FillArray ENDP

---------------PROTO
;为一个已存在的过程创建一个原型,声明了过程的名字和参数列表
;它允许在定义过程之前就调用该过程并验证调用时传递的参数和数目是否与定义向匹配
INVOKE要求调用的过程有一个合适的原型声明,过程的实现在INVOKE之前,PROC本身起到原型作用
复制PROC,把PROC更改为PROTO,去掉USES以及其后寄存器列表
Eaxmple PROC C,parm1:DWORD
如果实际参数尺寸<声明的参数尺寸,MASM会扩展到声明参数的大小 mov al,byte ptr ds:[]/ movzx eax,al/push eax
如果ADDR声明参数,push ADDR表示的参数地址
如果传入的字节,mov al byte ptr ds:[]/ push eax
如果传入是WORD,则sub esp,2/ push word ptr dr:[]


