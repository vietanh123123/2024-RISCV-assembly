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
    #Check index is valid
    bge a2, a1, fail # If index >= length of board, exit with failure
	add t0 a0 zero   # Base adress of board
    li t1 0  # Counter to keep track of the current index
    li a0 1 # Nothing happened yet


go_to_index:
    beq t1, a2, place_value # If counter == index, go to place_value
    addi t0, t0, 2 
    addi t1, t1, 1 # Increment counter
    j go_to_index # Loop until we reach the index
   

place_value:
    lh t2, 0(t0) # Load the value at the index
    bne t2, zero, end # If the value is not zero, exit with failure
    sh a3, 0(t0) # Store the new value at the index
    li a0 0 # Set a0 to 0 to indicate success
    j end # Exit

fail:
   li a0 1 # Set a0 to 1 to indicate failure

end: 
   jr ra
