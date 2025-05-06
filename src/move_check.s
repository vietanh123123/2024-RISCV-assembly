.text
.globl move_check
#
#	a0 buffer address
#	a1 buffer length
#
#   a0 == 1 iff left move possible and would change something
#         else 0
#

move_check:
    # Check if length is less than 2,
    li t0, 2
    blt a1, t0, fail         # If length < 2, no move possible

    mv t0, a0                # t0 = address of buffer
    li t1, 0                 # t1 = 0 (counter for elements in the buffer)
    li a0, 0                 # a0 = 0 (default value for no move possible)
    
    # First check: Look for any zero followed by non-zero (allows shifting)
    j check_zeros

check_zeros:
    lw t2, 0(t0)            # Get address of current element
    lh t3, 0(t2)            # Load value of current element
    beq t3, zero, found_zero # If zero, check next elements
    
    # Check if we have adjacent identical elements (allows merging)
    addi t4, t1, 1          # t4 = next position
    bge t4, a1, next_element # If at the end, move to next element
    
    lw t5, 4(t0)            # Get address of next element
    lh t6, 0(t5)            # Load value of next element
    beq t3, t6, move_possible # If adjacent elements are equal, move is possible
    
next_element:
    addi t0, t0, 4          # Move to next buffer element
    addi t1, t1, 1          # Increment counter
    blt t1, a1, check_zeros  # Continue if not at end
    j check_adjacent         # If no zeros found, check for adjacent identical values

found_zero:
    addi t4, t1, 1          # Position after zero
    bge t4, a1, next_element # If at the end, continue checking
    
    # Loop through remaining elements to find any non-zero
    mv t5, t0               # Save current position
    addi t5, t5, 4          # Move to next element
    mv t6, t1               # Save current counter
    addi t6, t6, 1          # Increment counter
    
zero_followed_check:
    lw t2, 0(t5)            # Get address of element
    lh t3, 0(t2)            # Load value
    bne t3, zero, move_possible # If non-zero found after zero, move is possible
    
    addi t5, t5, 4          # Next element
    addi t6, t6, 1          # Increment counter
    blt t6, a1, zero_followed_check # Continue if not at end
    
    j next_element          # Continue main loop if no non-zeros after this zero

check_adjacent:
    # Reset and check for adjacent identical values
    mv t0, a0               # Reset to buffer start
    li t1, 0                # Reset counter
    
adjacent_loop:
    addi t4, t1, 1          # Index of next element
    bge t4, a1, fail        # If at the end, no move possible
    
    lw t2, 0(t0)            # Get address of current element
    lh t3, 0(t2)            # Load value
    lw t5, 4(t0)            # Get address of next element
    lh t6, 0(t5)            # Load next value
    
    beq t3, t6, move_possible # If adjacent elements are equal, move is possible
    
    addi t0, t0, 4          # Move to next element
    addi t1, t1, 1          # Increment counter
    blt t1, a1, adjacent_loop # Continue if not at end
    j fail                  # No move possible

move_possible:
    li a0, 1                # Set return value to 1 (move possible)
    j end

fail:
    li a0, 0                # If no move possible, set a0 to 0

end: 
    jr ra
