.code16
.globl _start
_start: 
	jmp main

pr_msg:
	movb $0x0e, %ah
	movw $0x7e00, %bx
while:
	cmp $0, (%bx)
	je whileend
	movb %es:(%bx), %al 
	int $0x10 
	inc %bx
	jmp while
whileend:
	ret
main:
	movw $0, %ax
	movw %ax, %es
	movb %dl, (disknum)
	movb $2, %ah
	movb $1, %al
	movb $0, %ch
	movb $2, %cl
	movb $0, %dh
	movb (disknum), %dl
	movw $0x7e00, %bx
	int  $0x13
	call pr_msg		
	hlt
disknum:
	.byte 0x00

.= _start + 510
.word 0xaa55
.ascii "Hello, disk!"
