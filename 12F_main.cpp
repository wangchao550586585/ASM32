//������C/C++���ú�����
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
	scanf("%s", x);//("ǿ��VS C++����scanf��");
	//printf("ǿ��VS C++���ش�ӡ��");
	asmMain();
	return 0;
}