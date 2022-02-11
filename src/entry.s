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
	.word 0x0000
	.byte 0x0 
	.byte 0b10011010 
	.byte 0b11001111 
	.byte 0 
data_desc:
	.word 0xffff
	.word 0x0000
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

KERNEL_ENT_ADDR = 0x1000

disknum:
	.byte 0x0
main:
	movw $0, %ax
	movw %ax, %es
	movw $KERNEL_ENT_ADDR, %bx
	
	movb %dl, %ds:(disknum)
	movb $2, %ah
	movb $0x0F, %al
	movb $0, %ch
	movb $2, %cl
	movb $0, %dh
	movb %ds:(disknum), %dl
	int $0x13

	cli 
	lgdt (gdt_desc)
	movl %cr0, %eax
	or $1, %eax
	movl %eax, %cr0
	jmp $CODE_SEG, $prot_start

.code32
prot_start:
	jmp $CODE_SEG, $KERNEL_ENT_ADDR

.= _start + 510
.word 0xaa55
