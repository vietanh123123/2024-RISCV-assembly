.text
.globl move_left
.import "move_one.s"


#
#	a0 buffer address
#	a1 buffer length
#
#	|----|----|----|----|		|----|----|----|----|
#	|  0 |  2 |  0 |  4 |	=> 	|  2 |  4 |  0 |  0 |
#	|----|----|----|----|		|----|----|----|----|
#

# Every time we jump to move_one, the array will be shifted left by one position and return 1 if a move was made.
# The loop will continue until no more moves can be made, at which point it will return 0.

move_left:
    mv t0 , a0         # t0 = address of buffer
    mv t1 , a1         # t1 = length of buffer
loop:   
    jal move_one # Call move_one function
    beq a0, zero, end # If no move was made, exit the loop
    mv a0, t0 # Set a0 to the address of the buffer
    j loop # Repeat the process


end: 
  jr ra    