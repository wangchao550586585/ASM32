//复制并加密一个文件,C++内联汇编
#include <iostream>
#include <fstream>
#include "12B_translat.h"
using namespace std;
int main(int argcount, char * args[]) {
	argcount = 3;
	args[0] = "encode";
	args[1] = "../a.txt";
	args[2] = "../b.txt";
	// Read input and output files from the command line.
	if (argcount < 3) {
		cout << "Usage: encode infile outfile" << endl;
		return -1;
	}

	const int BUFSIZE = 2000;
	char buffer[BUFSIZE];
	unsigned int count;			// character count

	unsigned char encryptCode;
	cout << "Encryption code [0-255]? ";
	cin >> encryptCode;

	ifstream infile(args[1], ios::binary);
	ofstream outfile(args[2], ios::binary);

	cout << "Reading " << args[1] << " and creating "
		<< args[2] << endl;

	while (!infile.eof())
	{
		infile.read(buffer, BUFSIZE);
		count = infile.gcount();
		TranslateBuffer(buffer, count, encryptCode);
		outfile.write(buffer, count);
	}
	return 0;
}
