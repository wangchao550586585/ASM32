#include <stdio.h>
extern "C" void asm_main();
void main() {
	char x[10];
	scanf("%s", x);//("ǿ��VS C++����scanf��");
	printf("ǿ��VS C++���ش�ӡ��");
	asm_main();
}