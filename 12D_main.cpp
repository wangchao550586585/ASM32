#include <iostream>
#include <iomanip>
using namespace std;
extern "C" {
	//�ⲿ�Ļ�����Թ���
	void DisplayTable();
	void SetTextOutColor(unsigned color);
	//�ֲ�C++����
	int askForInteger();
	void showInt(int value, int width);
}

int main() {
	SetTextOutColor(0x1E);
	DisplayTable();
	return 0;
}
//��ʾ�û�����һ������
int askForInteger() {
	int n;
	cout << "Enter an integer between 1 and 90,000: ";
	cin >> n;
	return n;
}
//ָ�������ʾһ���з�������
void showInt(int value, int width) {
	cout << setw(width) << value;
}
