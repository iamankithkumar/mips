addi $a0,$0,1
fact:
li $t0, 50
 move $t1,$a0 # set i to n
 loop:
 blez $t1,exit # exit if done
 mul $t0,$t0,$t1 # build factorial
 addi $t1, $t1,-1 # i--
j loop
exit:
move $v0,$t0
 or      $a1, $zero, $s0
    ori     $v1, $zero, 1
    syscall
