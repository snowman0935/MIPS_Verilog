addi $t8,$t0,2
addi $t2,$t0,7
addi $t7,$t0,1
add $t1,$t0,$t2
loop:
	beq $t1,$t8,DONE
	sub $t1,$t1,$t7
	add $t4,$t1,$t0
	mul:
		beq $t4,$t0,loop
		add $t5,$t5,$t2
		sub $t4,$t4,$t7
		beq $t4,$t0,store
		j mul
store:
	add $t2,$t5,$t0
	add $t5,$t0,$t0
	j loop
DONE:
