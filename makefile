BUILD_DIR = build
SRC_DIR = src

ASM_FLAGS = --32 -c
C_FLAGS = -m32 -ffreestanding -fno-pic -c
LD_FLAGS_NO_DFA = -m elf_i386 --oformat binary # no default address
LD_FLAGS = $(LD_FLAGS_NO_DFA) -Ttext 0x1000

${BUILD_DIR}/os.bin: ${BUILD_DIR}/kernel_entry.bin ${BUILD_DIR}/bootldr.bin
	cat ${BUILD_DIR}/bootldr.bin ${BUILD_DIR}/kernel_entry.bin > ${BUILD_DIR}/os.bin

${BUILD_DIR}/kernel_entry.bin: ${BUILD_DIR}/kernel_entry.o $(BUILD_DIR)/main.o
	ld $(LD_FLAGS) -o ${BUILD_DIR}/kernel_entry.bin ${BUILD_DIR}/kernel_entry.o $(BUILD_DIR)/main.o

${BUILD_DIR}/bootldr.bin: ${BUILD_DIR}/bootldr.o
	ld $(LD_FLAGS_NO_DFA) -Ttext 0x7c00 -o ${BUILD_DIR}/bootldr.bin ${BUILD_DIR}/bootldr.o 

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	gcc $(C_FLAGS) $^ -o $@ 

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.s
	as $(ASM_FLAGS) $^ -o $@ 

clear:
	rm ${BUILD_DIR}/*
