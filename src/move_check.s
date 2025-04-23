.text
.globl move_check
#
#	a0 buffer address
#	a1 buffer length
#
#   a0 == 1 iff left move possible and would change something
#            else 0
#

move_check:
    
    # Initialize counter and result
    li t0, 0  # Counter for elements processed
    li s0, 0  # Result: 0 = no move possible
    
    # Check if buffer has at least 2 elements
    li t1, 2
    blt a1, t1, end_check  # If length < 2, no move possible
    
    # Start checking for conditions
check_loop:
    beq t0, a1, end_check  # If we've processed all elements, end
    
    # Load address of current element from buffer
    slli t1, t0, 2         # t1 = t0 * 4 (word offset)
    add t1, a0, t1         # t1 = buffer address + offset
    lw t2, 0(t1)           # t2 = address of current element
    lh t3, 0(t2)           # t3 = value at current element
    
    # Check if current element is last in row
    addi t4, a1, -1
    beq t0, t4, increment  # If last element, move to next iteration
    
    # Get next element
    lw t4, 4(t1)           # t4 = address of next element
    lh t5, 0(t4)           # t5 = value at next element
    
    # Check condition 1: empty space (0) to the left of a non-empty tile
    bne t3, zero, check_adjacent_equal  # If current is not empty, check next condition
    bne t5, zero, move_possible         # If current is empty and next is not, move is possible
    
check_adjacent_equal:
    # Check condition 2: two adjacent tiles with the same non-zero value
    beq t3, zero, increment  # If current is empty, no equal adjacent possible
    beq t5, zero, increment  # If next is empty, no equal adjacent possible
    bne t3, t5, increment    # If values are not equal, check next elements
    
    # If we get here, we found two adjacent equal non-zero values
move_possible:
    li s0, 1               # Set result to 1 (move is possible)
    j end_check            # We can end the check
    
increment:
    addi t0, t0, 1         # Increment counter
    j check_loop           # Continue checking
    
end_check:
    mv a0, s0             # Set return value   
    jr ra                 # Return