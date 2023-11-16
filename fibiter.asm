# - Iterative version
# Computes and prints Fibonacci numbers. 
# The corresponding C code might look like this:
#
#   int fib(int N) {
#       int fib, prev1, prev2;
#
#       if (N == 0) return 0;
#       if (N == 1) return 1;
#
#       prev2 = 0;
#       prev1 = 1;
#       N = N - 1;
#       do {
#           fib = prev1 + prev2;
#           prev2 = prev1;
#           prev1 = fib;
#           N = N - 1;
#       } while (N > 0);
#
#       return fib;
#   }
#

    .text
    .globl __start

__start:
    or      $s0, $zero, $zero   # s0 saves the current value of N
    ####################################################################
    ori     $s1, $zero, 50   # Max N (+1)

# The outer loop calls fib with increasing values of N and
# prints the results
outerloop:
    or      $a0, $zero, $s0     # Call fib(N)
    jal     fib
    or      $zero, $zero, $zero # nop in delay slot
    or      $s2, $zero, $v0     # Save the returned value of fib(N)

    # Print N with print_int
    or      $a0, $zero, $s0
    ori     $v0, $zero, 1
    syscall

    # Print a space with print_char
    ori     $a0, $zero, 0x20    # Space is ASCII 32 = 0x20
    ori     $v0, $zero, 11      # print_char
    syscall
    
    # Print the saved return value fib(N) with print_int
    or      $a0, $zero, $s2
    or      $v0, $zero, 1
    syscall

    # Print a newline with print_char
    ori     $a0, $zero, 0xa     # Newline is ASCII 10 = 0xa
    ori     $v0, $zero, 11      # print_char
    syscall

    # Increment N and loop until we reach max N
    addi    $s0, $s0, 1
    bne     $s0, $s1, outerloop
    or      $zero, $zero, $zero # nop in delay slot

    # Exit
    addiu   $v0, $zero, 10      # Prepare to exit (system call 10)
    syscall                     # Exit


# Fib takes a single argument N in $a0, and returns fib(N) in $v0
# Uses registers as follows:
#   t1 - prev1
#   t2 - prev2

fib:
    # fib(0) case (return 0)
    or      $v0, $zero, $zero
    beq     $a0, $zero, end
    or      $zero, $zero, $zero # nop in delay slot

    # fib(1) case (return 1)
    ori     $v0, $zero, 1
    beq     $a0, $v0, end
    or      $zero, $zero, $zero # nop in delay slot

    # Else
    or      $t2, $zero, $zero   # prev2 = 0;
    ori     $t1, $zero, 1       # prev1 = 1;
    addi    $a0, $a0, -1        # N = N - 1;

fibloop:
    add     $v0, $t1, $t2       # fib = prev1 + prev2
    or      $t2, $zero, $t1     # prev2 = prev1;
    or      $t1, $zero, $v0     # prev1 = fib;
    addi    $a0, $a0, -1        # N = N - 1;
    bgtz    $a0, fibloop        # while (N > 0)
    or      $zero, $zero, $zero # nop in delay slot

end:
    jr      $ra
    or      $zero, $zero, $zero # nop in delay slot
