.text
.globl complete_move
.import "merge.s"
.import "move_left.s"


#
#	a0 buffer address
#	a1 buffer length
#
#	|----|----|----|----|		|----|----|----|----|
#	|  2 |  2 |  0 |  4 |  => 	|  4 |  4 |  0 |  0 |
#	|----|----|----|----|		|----|----|----|----|
#
#   BONUS: Return the number of merges in a0 and the
#          total base score of the merges in a1.


complete_move:
   addi sp, sp, -8
   sw s0, 0(sp) # Store s0 on stack
   sw s1, 4(sp) # Store s1 on stack
   
   addi sp , sp , -12 



   sw a0, 0(sp) # Store a0 on stack
   sw a1, 4(sp) # Store a1 on stack
   sw ra, 8(sp) # Store return address on stack

   jal move_left # Call move_left function

   lw a0, 0(sp) # Restore a0 from stack
   lw a1, 4(sp) # Restore a1 from stack
   lw ra, 8(sp) # Restore return address from stack
   
  
   jal merge # Call merge function

   mv s0, a0 # Store the number of merges in s0
   mv s1, a1 # Store the total base score of merges in s1

   lw a0, 0(sp) # Restore a0 from stack
   lw a1, 4(sp) # Restore a1 from stack
   lw ra, 8(sp) # Restore return address from stack



   jal move_left # Call move_left function
   
   lw a0, 0(sp) # Restore a0 from stack
   lw a1, 4(sp) # Restore a1 from stack
   lw ra, 8(sp) # Restore return address from stack
   addi sp, sp, 12 # Restore stack pointer


end:
   mv a0, s0 # Return the number of merges in a0
   mv a1, s1 # Return the total base score of merges in a1
   lw s0, 0(sp) # Restore s0 from stack
   lw s1, 4(sp) # Restore s1 from stack
   addi sp, sp, 8 # Restore stack pointer
   jr ra
