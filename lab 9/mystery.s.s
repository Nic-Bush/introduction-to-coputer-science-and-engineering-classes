
	.text

main:
	li $a0, 0
	jal putDec
	li $a0, '\n'
	li $v0, 11
	syscall
	
	li $a0, 1
	jal putDec
	li $a0, '\n'
	li $v0, 11
	syscall
	
	li $a0, 196
	jal putDec
	li $a0, '\n'
	li $v0, 11
	syscall
	
	li $a0, -1
	jal putDec
	li $a0, '\n'
	li $v0, 11
	syscall
	
	li $a0, -452
	jal putDec
	li $a0, '\n'
	li $v0, 11
	syscall
	
	li $a0, 2
	jal mystery
	move $a0, $v0
	jal putDec
	li $a0, '\n'
	li $v0, 11
	syscall

	li $a0, 3
	jal mystery
	move $a0, $v0
	jal putDec
	li $a0, '\n'
	li $v0, 11
	syscall

	li 	$v0, 10		# terminate program
	syscall
#i basically took all the code for base 10 in the project and #modified it to base 2
neg:#sets neg to 1
move $a1, 1		#make a1 1(show that it is neg)
move $a2, 1		#will use to add the one
j putDec1
reverse: #reverse if neg
beqz $t0, set1
move $t0, 0
j add1
set1:#sets if t0 was 0
move $t0, 1
j add2
add1:#if term is 0 can add and get rid of a2
beqz $a2, Save
addi $t0, 1
move $a2,0
j Save
add2:#if digit is one make it zero when adding but keep a2
beqz $a2, Save
move $t0, 0
j Save
putDec:
lui $a1,0x8000
and $a1, $a1, $a0
bnez $a1, neg
putDec1: 
	addi $sp,$sp,-8	# get 2 words of stack
	sw $ra,0($sp)	# store return address
	
	# The number is printed as follows:
	# It is successively divided by the base (2) and the 
	# reminders are printed in the reverse order they were found
	# using recursion.

	remu	$t0,$a0,2	# $t0 <- $a0 % 2
	addi	$t0,$t0,'0'	# $t0 += '0' ($t0 is now a digit character)
	divu	$a0,$a0,2	# $a0 /= 2
	beqz	$a0,onedig	# if( $a0 != 0 ) {
	bnez $a1, reverse #if a1 isnt zero it is neg
Save: sw	$t0,4($sp)	#   save $t0 on our stack
	jal	putdec1		#   putint() (putint will deliberately use and modify $a0)
	lw	$t0,4($sp)	#   restore $t0
	                        # } 
onedig:	move	$a0, $t0
	li 	$v0, 11
	syscall			# putc #$t0
	#putc	$t0		# output the digit character $t0
	lw	$ra,0($sp)	# restore return address
	addi	$sp,$sp, 8	# restore stack
	jr	$ra		# return

#prints all but if the thing is pos or neg i dont know how to #guarantee a 1 or zero at front	
		jr	$ra		# returnv
#will keep doing recur until a0 = 0 in which case it will set v0 to 0 and start juming to 
mystery:
slt $t5, $a0, $0
beqz $t5,mystery1
jr $ra		#if a neg number is sent... will send back 
mystery1:bne $0, $a0, recur 	#if a0 is not 0 go to recur 
 	li $v0, 0 		#v0 = 0
 	jr $ra 			#go to return address
 recur: sub $sp, $sp, 8 	#sp-=8
 	sw $ra, 4($sp) 	#save ra on stack
 	sub $a0, $a0, 1 	#a0 -= 1
 	jal mystery1 		#repeat mystery
 	sw $v0, 0($sp) 	#save v0 on stack keeps saving different #'s
 	jal mystery1 		# repeat mystery
 	lw $t0, 0($sp) 	#t0 is old val of v0
 	addu $v0, $v0, $t0 	#v0 = v0 + t0
 	addu $v0, $v0, 1 	# v0 = v0 + 1
 	add $a0, $a0, 1 	# a0 = a0 + 1
 	lw $ra, 4($sp) 	# load old ra
 	add $sp, $sp, 8 	# return stack pointer
 	jr $ra 			#jump

#seems to be 2^n - 1 but will reject all numers if less than #zero