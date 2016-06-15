main:
	lui	$a0,0x8000
	jal	first1pos
	jal	printv0
	lui	$a0,0x0001
	jal	first1pos
	jal	printv0
	li	$a0,1
	jal	first1pos
	jal	printv0
	add	$a0,$0,$0
	jal	first1pos
	jal	printv0
	li	$v0,10
	syscall

first1pos:	# your code goes here
addi $v0, $0, 32		#make initial val 32
addi $t1, $0, -1		#create escape var if all zeroes
itteration:
addi $v0, $v0, -1	#sub 1
sll $a0, $a0, 1		#shift left
slt $t0, $0, $a0		#if 0<a0 set 1
beq $t1, $v0, END	#if all zeroes end it
bne $t0, $0, itteration	#if not less than zero re do
END:
jr $ra

printv0:
	addi	$sp,$sp,-4
	sw	$ra,0($sp)
	add	$a0,$v0,$0
	li	$v0,1
	syscall
	li	$v0,11
	li	$a0,'\n'
	syscall
	lw	$ra,0($sp)
	addi	$sp,$sp,4
	jr	$ra
