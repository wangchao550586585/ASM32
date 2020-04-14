-----------------IF-----------------
if(op1==op2){x=1,y=2}

mov eax,op1
cmp eax,op2
jne L1		;eax!=op2,跳到L1
mov X,1
mov Y,2
L1:

mov eax,op1
cmp eax,op2
je L1
jmp L2
L1:mov X,1
   mov Y,2
L2:

-----------------AND-----------------
if(al>bl)AND (bl>cl){x=1}

---短路求值
cmp al,bl
ja L1
jmp next
L1:cmp bl,cl
	ja  L2
	jmp next
L2:mov X,1
next:

cmp al,bl
jbe next
cmp bl,cl
jbe next
mov X,1
next:

-----------------OR-----------------
if(al>bl)OR(bl>cl)x=1

cmp al,bl
ja L1
cmp bl,cl
jbe next
L1:mov X,1
next:

-----------------WHILE-----------------
while(val1<val2){val1++,val2++}

mov eax,val1
@@while:
	cmp eax,val2
	jnl endwhile
	inc eax
	dec val2
	jmp @@while
endwhile:
	mov val1,eax

-----------------嵌套WHILE中的IF----------------
int array[]={10,60,20,33,72}
int sample=50
int ArraySize=sizeof array/sizeof sample
int index=0
int sum=0
while(index<ArraySize){
	if(array[index]>sample){
		sum+=array[index]
		}
index++
}

;使用寄存器代替变量,以减少内存访问提高执行速度
.data
sum		 DWORD 0
sample	 DWORD 50
array	 DWORD 10,60,20,33,72
ArraySize=($-array)/TYPE array
.code
main PROC
	 mov eax,0			;sum
	 mov edx,sample
	 mov esi,0			;index
	 mov ecx,ArraySize

  L1:cmp esi,ecx
	 jl L2
	 jmp L5

  L2:cmp array[esi*4],edx
	 jg L3
	 jmp L4

  L3:add eax,array[esi*4]
  L4:inc esi
     jmp L1
  L5:mov sum,eax
main ENDP
END main

-----------------.REPEAT/.WHILE----------------
mov eax,0
.WHILE eax<10
	inc eax
	call WriteString
	call Crlf
.ENDW

;do-while
mov eax,0
.REPEAT
	inc eax
	call WriteString
	call Crlf
.UNTIL eax==10

------------------------------
while(op1<op2){
	op1++;
	if(op2==op3)X=2;
	else X=3;
}

.data
X DWORD 0
op1 DWORD 2
op2 DWORD 4
op3 DWORD 5
.code 
	mov eax,op1
	mov ebx,op2
	mov ecx,op3
	.WHILE eax<ebx
		inc eax
		.IF ebx==ecx
			mov X,2
		.ELSE 
			mov X,3
		.ENDIF
	.ENDW

