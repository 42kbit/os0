BUILD_DIR = build
SRC_DIR = src

${BUILD_DIR}/entry.bin: ${BUILD_DIR}/entry.o
	ld -m elf_i386 -Ttext 0x7c00 -o ${BUILD_DIR}/entry.bin ${BUILD_DIR}/entry.o --oformat binary

${BUILD_DIR}/entry.o: ${SRC_DIR}/entry.s
	gcc -m32 -c ${SRC_DIR}/entry.s -o ${BUILD_DIR}/entry.o  

clear:
	rm ${BUILD_DIR}/*
