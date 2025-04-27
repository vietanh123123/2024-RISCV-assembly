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
   
   mv t1, a0 # t1 = address of buffer
   addi sp , sp , -8 
   sw t1, 0(sp) # Store t1 on stack
   sw ra, 4(sp) # Store return address on stack

   jal move_left # Call move_left function

   lw t1, 0(sp) # Restore t1 from stack
   lw ra, 4(sp) # Restore return address from stack

   mv a0, t1 # Set a0 to the address of the buffer
   
   sw t1, 0(sp) # Store t1 on stack
   sw ra, 4(sp) # Store return address on stack

   jal merge # Call merge function

   lw t1, 0(sp) # Restore t1 from stack
   lw ra, 4(sp) # Restore return address from stack

   mv a0, t1 # Set a0 to the address of the buffer

   sw t1, 0(sp) # Store t1 on stack
   sw ra, 4(sp) # Store return address on stack

   jal move_left # Call move_left function
   
   lw t1, 0(sp) # Restore t1 from stack
   lw ra, 4(sp) # Restore return address from stack
   addi sp, sp, 8 # Restore stack pointer


end:
    jr ra
