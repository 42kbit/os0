.code16
.globl _start
_start: 
	jmp main

gdt_start:
null_desc:
	.int 0
	.int 0
code_desc:
	.word 0xffff 
	.word 0x0
	.byte 0x0 
	.byte 0b10011010 
	.byte 0b11001111 
	.byte 0 
data_desc:
	.word 0xffff
	.word 0x0
	.byte 0x0 
	.byte 0b10010010
	.byte 0b11001111
	.byte 0x0
gdt_end:

gdt_desc:
	.word gdt_end - gdt_start - 1
	.long gdt_start

CODE_SEG = code_desc - gdt_start
DATA_SEG = data_desc - gdt_start

main:
	cli 
	lgdt (gdt_desc)
	movl %cr0, %eax
	or $1, %eax
	movl %eax, %cr0
	jmp $0x08, $prot_start

.code32
prot_start:
	movb $'A', %al
	movb $0x0f, %ah
	movw %ax, (0xb8000) 
	jmp $CODE_SEG, $prot_start

.= _start + 510
.word 0xaa55
