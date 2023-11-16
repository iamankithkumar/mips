    #bubble sort
    .data
     
    endLine: .asciiz "\n"
    array:	.word 5, 3, 4, 6, 1
     
    .text
     
    display:
    	la $s3,array                   # address
    	li $t0,5                        # cnt
    	li $t1,0
    	startLoop:
    	beq $t0,$t1,endLoop
    	
    	lw $t3,0($s3)
    	
    	li $v0,1
    	move $a0,$t3
    	syscall
    	
    	li $v0,4
    	la $a0,endLine
    	syscall
    	
    	addi $t1, $t1, 1
    	addi $s3, $s3, 4
    	j startLoop
    endLoop:
    	 li $v0, 10              #exit
    	  syscall