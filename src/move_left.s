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
   #Store a0, a1 and ra on stack
    addi sp, sp, -12 # Decrease stack pointer
loop: 
    
    sw a0, 0(sp) # Store t0 on stack
    sw a1, 4(sp) # Store t1 on stack 
    sw ra, 8(sp) # Store return address on stack

    jal move_one # Call move_one function
    

    beq a0, zero, end # If no move was made, exit the loop

    lw a0, 0(sp) # Restore t0 from stack
    lw a1, 4(sp) # Restore t1 from stack
    lw ra, 8(sp) # Restore return address from stack

    j loop # Repeat the process


end: 

  lw a0, 0(sp) # Restore t0 from stack
  lw a1, 4(sp) # Restore t1 from stack
  lw ra, 8(sp) # Restore return address from stack
  addi sp, sp, 12 # Restore stack pointer 
  jr ra     