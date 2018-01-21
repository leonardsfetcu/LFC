	.text
	.globl main
main:
	li		$t0, 1
	li		$t1, 2
	add		$t0, $t0, $t1
	li		$t1, 3
	add		$t0, $t0, $t1
	sw		$t0, a
	li		$t0, 43
	sw		$t0, bb
	li		$t0, 23
	li		$t1, 54
	add		$t0, $t0, $t1
	li		$t1, 1
	add		$t0, $t0, $t1
	li		$t1, 4
	add		$t0, $t0, $t1
	sw		$t0, x
	li		$t0, 3
	li		$t1, 1
	add		$t0, $t0, $t1
	li		$t1, 3
	add		$t0, $t0, $t1
	li		$t1, 4
	add		$t0, $t0, $t1
	sw		$t0, y
	lw		$a0, x
	li		$v0, 1
	syscall
	la		$a0, newLine
	li		$v0, 4
	syscall
	lw		$a0, y
	li		$v0, 1
	syscall
	la		$a0, newLine
	li		$v0, 4
	syscall
	lw		$a0, bb
	li		$v0, 1
	syscall
	la		$a0, newLine
	li		$v0, 4
	syscall
	lw		$a0, a
	li		$v0, 1
	syscall
	la		$a0, newLine
	li		$v0, 4
	syscall
	li		$v0, 10
	syscall
	.data
a:			.word 6
bb:			.word 0
x:			.word 0
y:			.word 0
newLine:		.asciiz "\n"