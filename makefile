BUILD_DIR = build
SRC_DIR = src

${BUILD_DIR}/os.bin: ${BUILD_DIR}/kernel_entry.bin ${BUILD_DIR}/entry.bin
	cat ${BUILD_DIR}/entry.bin ${BUILD_DIR}/kernel_entry.bin >> ${BUILD_DIR}/os.bin

${BUILD_DIR}/kernel_entry.bin: ${BUILD_DIR}/kernel_entry.o
	ld -m elf_i386 -Ttext 0x1000 -o ${BUILD_DIR}/kernel_entry.bin ${BUILD_DIR}/kernel_entry.o --oformat binary

${BUILD_DIR}/entry.bin: ${BUILD_DIR}/entry.o
	ld -m elf_i386 -Ttext 0x7c00 -o ${BUILD_DIR}/entry.bin ${BUILD_DIR}/entry.o --oformat binary

${BUILD_DIR}/entry.o: ${SRC_DIR}/entry.s
	as --32 -c ${SRC_DIR}/entry.s -o ${BUILD_DIR}/entry.o  

${BUILD_DIR}/kernel_entry.o: ${SRC_DIR}/kernel_entry.c
	gcc -m32 -fno-pic -ffreestanding -c -o ${BUILD_DIR}/kernel_entry.o ${SRC_DIR}/kernel_entry.c 

clear:
	rm ${BUILD_DIR}/*
