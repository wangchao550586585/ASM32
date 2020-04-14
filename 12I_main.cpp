//16位汇编,与BorlandC++程序链接
#include <iostream>		
using namespace std;
extern "C" unsigned long LongRandom();
const int ARRAY_SIZE = 500;
int main() {
	unsigned long* rArray = new unsigned long[ARRAY_SIZE];
	for (unsigned i = 0; i < ARRAY_SIZE; i++)
	{
		rArray[i] = LongRandom();
		cout << rArray[i] << ',';
	}
	cout << endl;
	return 0;
}