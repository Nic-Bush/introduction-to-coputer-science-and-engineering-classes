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
addi $t0, $0, 0		#set to 0
lui $t0,0x8000		#load mask
addi $v0, $0, 32	#make 32
itteration:
addi $v0, $v0, -1	#sub 1
and $t1, $t0, $a0	#if have one same num make non zero
srl $t0, $t0, 1		#shift
beq $t0, $0, END	#breaks if t0 gets to 0
beq $t1, $0, itteration	#if t1 is zero repeat
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
