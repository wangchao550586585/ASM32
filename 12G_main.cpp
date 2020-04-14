#include <stdio.h>
extern "C" void asm_main();
void main() {
	char x[10];
	scanf("%s", x);//("强制VS C++加载scanf库");
	printf("强制VS C++加载打印库");
	asm_main();
}