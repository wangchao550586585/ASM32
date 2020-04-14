mov ah,0
mov al,'8'
add al,'2'	;ax存放2个ASCII十进制数字相加的和	
aaa			;aaa把AX中的和转换成2个未压缩的十进制字
or ax,3030h	;or30转换成相应ASCII数字

.data
val1 BYTE '8'
val2 BYTE '9'
.code 
mov ah,0
mov al,val1
sub al,val2
aas			
pushf
	or al,30h	
popf

.data
AscVal BYTE 05h,06h
.code
mov bl,ascVal
mov al,ascVal+1
mul bl			;必须使用未压缩的10进制数
aam				;把乘积的二进制转换成未压缩十进制

.data
.code
	mov ax,0307h
	aad			;除法之前,需要执行aad调整AX中未压缩十进制被除数
	mov bl,5
	div bl		

