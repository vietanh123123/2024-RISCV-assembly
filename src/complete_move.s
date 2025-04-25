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
   
   jal move_left # Call move_left function

   mv a0, t1 # Set a0 to the address of the buffer

   jal merge # Call merge function

   mv a0, t1 # Set a0 to the address of the buffer

   jal move_left # Call move_left function



end:
    jr ra
