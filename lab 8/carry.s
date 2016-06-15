.main :
	addu $t2, $t3, $t4	#add them together
	sltu $t2, $t2, $t3	#check if result is less than
	li $v0, 10		#used for checking
	syscall		#used to error check