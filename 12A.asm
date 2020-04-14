//定义单个汇编
extern "C" bool AsmFindArray(long n, long array[], long count) {
}
定义多个汇编
extern "C" {
	bool AsmFindArray(long n, long array[], long count);
	bool FindArray(long n, long array[], long count);
}