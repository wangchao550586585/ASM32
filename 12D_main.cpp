#include <iostream>
#include <iomanip>
using namespace std;
extern "C" {
	//外部的汇编语言过程
	void DisplayTable();
	void SetTextOutColor(unsigned color);
	//局部C++函数
	int askForInteger();
	void showInt(int value, int width);
}

int main() {
	SetTextOutColor(0x1E);
	DisplayTable();
	return 0;
}
//提示用户输入一个整数
int askForInteger() {
	int n;
	cout << "Enter an integer between 1 and 90,000: ";
	cin >> n;
	return n;
}
//指定宽度显示一个有符号整数
void showInt(int value, int width) {
	cout << setw(width) << value;
}
