#include <stdint.h>

static void display_text(char* msg){
	uint16_t i = 0;
	while (*msg != '\n')
	{
		*((char*)0xb8000 + i*2) = *(msg++);	
		++i;
	}	
	return;
}

void _main(void) {
	char* msg = "Hello, world!\n";
	display_text(msg);
	return;
}
