######################################################################
# File name: sarah_gibbons_cs2315_asm4.asm
# Author: Sarah Gibbons
# Assignment # : 4
# Date: 11/13/16
# Functional description:
# Rmult function performs recursive multiplication on two non-negative
# integers, a and b, that are input by the user.
######################################################################
      .data
      .align		2
p_1: .asciiz "Enter a nonnegative integer a : "
p_2: .asciiz "Enter a nonnegative integer b : "
ans: .ascii "Recursive multiplication a*b =  "
      .text
      .globl main
main:
      la $a0, p_1 	  # get the first integer, a
      jal GetValue    # call to get user input
      move $s0, $v0

      la $a0, p_2		  # get the second integer, b
      jal GetValue    # call to get user input
      move $s1, $v0

      move $a0, $s0
      move $a1, $s1

      jal Rmult		     # call recursive multiplication function
      move $s2, $v0

      la $a0, ans		   # print the answer
      move $a1, $s2
      jal PrintInt

      li $v0, 10		    # exit
      syscall

Rmult:
      addi $sp, $sp -8 	# push the stack
      sw $a0, 4($sp) 		# Ssve $a0
      sw $ra, 0($sp) 		# save the $ra

      seq $t0, $a1, $zero 	# if (a == 0) return
      addi, $v0, $zero, 0 	# set return value
      bnez $t0, Return

      addi $a1, $a1, -1 	# set b = b-1
      jal Rmult 		      # recursive call
      lw $a0, 4($sp) 		  # retrieve a
      add $v0, $a0, $v0 	# return a+multiply(a, b-1)

Return:
      lw $ra, 0($sp) 		 # pop the stack
      addi $sp, $sp, 8
      jr $ra

GetValue:
      li $v0, 4		       # print the prompt (stored in $a0)
      syscall

      move $a0, $a1
      li $v0, 5		      # read the integer value.
      syscall

      jr $ra			      #return $ra

PrintInt:
      li $v0, 4	        # print string
      syscall

      move $a0, $a1	    # move integer value to $a0 and then print
      li $v0, 1
      syscall

      jr $ra	          #return $ra
