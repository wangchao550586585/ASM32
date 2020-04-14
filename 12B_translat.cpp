
void TranslateBuffer(char * buf, unsigned count,
	unsigned char eChar)
{
	__asm {
		mov esi, buf; set index register
		mov ecx, count   /* set loop counter */
		mov al, eChar
		L1 :
		xor[esi], al
			inc  esi
			Loop L1
	} // asm

}