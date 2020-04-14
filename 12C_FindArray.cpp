#include "12C_findarr.h"
bool FindArray(long searchVal, long array[], long count) {
	for (int  i = 0; i <count; i++)
		if (array[i]== searchVal)
			return true;
	return false;
}