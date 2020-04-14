//汇编调用C/C++内置函数库
#include <stdio.h>
#include <string>
#include <strstream>
using namespace std;

extern "C" void asmMain();
extern "C" void printSingle(float d, int precision);

void printSingle(float d, int precision)
{
	strstream temp;
	temp << "%." << precision << "f" << '\0';
	printf(temp.str(), d);
}

int main()
{
	char x[10];
	scanf("%s", x);//("强制VS C++加载scanf库");
	//printf("强制VS C++加载打印库");
	asmMain();
	return 0;
}