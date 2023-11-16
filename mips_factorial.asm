          .data
      str:  .asciiz "Hellow World = "
      num:  .word  50          
        .text
              la $a0, num   # argument 0 = 2
     	  lw $a0, 0($a0)
     	  jal  factorial
     	  add  $a0, $v0,$0
              li   $v0, 1        # system call code for print_int
              #add  $a0, $v0,$0       # integer to print
              syscall          # print it
              li $v0, 10              #exit
    	  syscall
     
    # $s0 = result
    factorial: addi $sp, $sp, -8  # make room
               sw   $a0, 4($sp)   # store $a0
               sw   $ra, 0($sp)   # store $ra
               addi $t0, $0, 2    
               slt  $t0, $a0, $t0 # a <= 1 ?
               beq  $t0, $0, else # no: go to else  
               addi $v0, $0, 1    # yes: return 1
               addi $sp, $sp, 8   # restore $sp
               jr   $ra           # return
         else: addi $a0, $a0, -1  # n = n - 1
               jal  factorial     # recursive call
               lw   $ra, 0($sp)   # restore $ra
               lw   $a0, 4($sp)   # restore $a0
               addi $sp, $sp, 8   # restore $sp
               mul  $v0, $a0, $v0 # n * factorial(n-1)
               jr   $ra           # return
     
     
           

