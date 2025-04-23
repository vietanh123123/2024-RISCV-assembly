.text
.globl place

# 	a0 board address
# 	a1 board length
#	a2 field number to place into
#	a3 number to place
#
#	a0 == 0 iff place succesfull else 1
#

place:
	add t0 a0 zero   # Base adress of board
    li t1 0  # Counter for length of how many elements are checked
    li a0 0 # Set a0 to 0 to indicate success


go_to_index:
    
    beq a2 zero place_value # if index is 0, go to place_value
    addi t0 t0 2 # Increment by 2 for halfword
    addi a2 a2 -1 # Decrement index
    addi t1 t1 1 # Increment counter
    j go_to_index # Jump to go_to_index

place_value:
    lh t2 0(t0) # Load current element of board
    bne t2 zero fail # Fail if the position is not empty
    sh a3 0(t0) # Store the number in the board
    j end # Jump to end

fail:
   li a0 1 # Set a0 to 1 to indicate failure

end: 
   jr ra
