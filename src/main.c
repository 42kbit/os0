void _main(void) {
	char* msg = "Hello, world!";
	int i = 0;
	while (i < 13) {
		*((char*)0xb8000 + i*2) = msg[i];
		++i;
	}
	return;
}
