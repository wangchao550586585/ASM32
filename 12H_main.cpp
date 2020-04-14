//16位汇编,与BorlandC++程序链接
//读取指定驱动器,扇区的扇区数量的数据
#include <iostream>
#include <stdlib.h>
#include <conio.h>
using namespace std;
const int SECTOR_SIZE = 512;
extern "C" void  ReadSector(char * buffer, long startSector, int driveNum, int numSectors);
void DisplayBuffer(const char * buffer, long startSector, int numSectors) {
	int n = 0;
	long last = startSector + numSectors;
	for (long sNum = startSector; sNum < last; sNum++) {
		cout << "\nSector " << sNum
			<< "-------------------"
			<< "-------------------\n";
		for (int i = 0; i < SECTOR_SIZE; i++) {
			char ch = buffer[n++];
			if (unsigned(ch) < 32 || unsigned(ch) > 127)
				cout << '.';
			else
				cout << ch;
		}
		cout << endl;
		getch();
	}
}
int main() {
	char * buffer;
	long startSector;
	int driveNum;
	int numSectors;

	system("CLS");
	cout << "Sector display program.\n\n"<< "Enter drive ";
	cin >> driveNum;
	cout << "Starting sector number to read: ";
	cin >> startSector;
	cout << "Number of sectors to read:";
	cin >> numSectors;
	buffer = new char[numSectors*SECTOR_SIZE];
	cout << "\n\nReading sectors" << startSector << " - " << (startSector + numSectors) << "from Drive" << driveNum << endl;
	ReadSector(buffer, startSector, driveNum, numSectors);
	DisplayBuffer(buffer, startSector, numSectors);
	system("CLS");
	return 0;
}
