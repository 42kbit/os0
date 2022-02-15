.code32
.extern _main
_asm_kernel_entry:
	jmp $0x8, $_main
