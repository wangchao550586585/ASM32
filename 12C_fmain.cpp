#include <iostream>
#include <time.h>
#include "12C_findarr.h"
using namespace std;
int main() {
	const unsigned ARRAY_SIZE = 10000;
	const unsigned LOOP_SIZE = 1000000;
	long array[ARRAY_SIZE];
	for (unsigned i = 0; i < ARRAY_SIZE; i++)
		array[i] = rand();
	long searchVal;
	time_t startTime, endTime;
	cout << "Enter val to find: ";
	cin >> searchVal;
	cout << "Please wait. This will take between 10 and 30 seconds... \n";

	time(&startTime);
	bool found = false;
	for (int  n = 0; n < LOOP_SIZE; n++)
		found = FindArray(searchVal, array, ARRAY_SIZE);
	time(&endTime);
	cout << "Elapsed CPP time: " << long(endTime - startTime) << "seconds. Found = " << found << endl;
	
	time(&startTime);
	 found = false;
	for (int n = 0; n < LOOP_SIZE; n++){
		found = AsmFindArray(searchVal, array, ARRAY_SIZE);
	}
	time(&endTime);
	cout << "Elapsed CPP time: " << long(endTime - startTime) << "seconds. Found = " << found << endl;

	return 0;
}