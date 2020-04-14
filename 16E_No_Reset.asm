;��ֹ��ctrl-alt-delete����ϵͳ,ֻ��ͨ��ctrl-alt-��shift-del
.model tiny
.386
.code
	rt_shift	EQU		01h		;��shift:�ڼ���״̬��־�ֽڵ�0λ
	ctrl_key	EQU		04h		;ctrl��:λ2
	alt_key		EQU		08h		;alt��:λ3
	del_key		EQU		53h		;del����ɨ����
	kybd_port	EQU		60h		;��������˿�
	ORG	100h					;����һ��COM����
start:
	jmp setup					;��ת��TSR(�ڴ�פ������)��װ����
int9_handler PROC FAR
	sti							;����Ӳ���ж�
	pushf						
	push es
	push ax
	push di

;���Ƽ��̱�־��AH
L1:	mov ax,40h
	mov es,ax
	mov di,17h
	mov ah,es:[di]

;����ctrl��alt
L2:	test ah,ctrl_key
	jz L5
	test ah,alt_key
	jz L5

;����Del����shift��
L3:	in al,kybd_port
	cmp al,del_key
	jne L5
	test ah,rt_shift		;����
	jnz L5

L4:	and ah,NOT ctrl_key		;ֻ����ͬʱ������Shiftʱ�������û�����,����������ctrlλ,��Ч��ֹ���û���ͼ������������ͼ
	mov es:[di],ah			;�ָ����̱�־
L5:	pop di
	pop ax
	pop es
	popf
	jmp cs:[old_interrupt9]
old_interrupt9 DWORD ?
int9_handler ENDP

end_ISR label BYTE

setup:
	mov ax,3509h						;��ȡint9�м�����
	int 21h
	mov word ptr old_interrupt9,bx		;����ԭint9�м�����
	mov word ptr old_interrupt9+2,es
	
	mov ax,2509h						;����INT9�м�����
	mov dx,offset int9_handler
	int 21h

	;int21h-32h���ص�MS-DOS,����פ�����������ڴ���,�ù����Զ�������PSP��ʼ-DX��ָ����ƫ�ƴ�����������
	mov ax,3100h						;��ֹ��פ��
	mov dx,OFFSET end_ISR				;ָ��פ�������ĩβ
	shr	dx,4							;����16
	inc dx								;���ϰ��ڽ���ȡ��
	int 21h								;ִ��MS-DOS���ܵ���
END start

