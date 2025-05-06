.text
.globl move_check
#
#	a0 buffer address
#	a1 buffer length
#
#   a0 == 1 iff left move possible and would change something
#         else 0
#

# Case 1: first element is 0 
# Case 2: first element is not 0 

move_check:
    # Check if length is less than 2,
    li t0, 2
    blt a1, t0, fail         # If length < 2, no move possible

    mv t0, a0 # t0 = address of buffer
    li t1, 1 # t1 = 1 (counter for elements in the buffer)
    
    li a0 , 0 # a0 = 0 (default value for no move possible)
    
    lw t2 , 0(t0) # address of the first element of the buffer
    lh t3 , 0(t2) # load the value of the first element of the buffer
    
    addi t0, t0, 4 # move to the next element of the buffer
    addi t1, t1, 1 # increment the counter
    bne t3, zero, case2 # if the first element is not 0, go to case2

case1:    
     # Traverse until we get a non-zero element otherwise return 0
    bgt t1, a1, end # If counter exceeds length, exit loop
    lw t2 , 0(t0) # address of the current element of the buffer
    lh t3 , 0(t2) # load the value of the current element of the buffer
    addi t0 , t0, 4 # move to the next element of the buffer
    addi t1 , t1, 1 # increment the counter
    beq t3, zero, case1 # if the current element is 0, loop again 
    li a0 , 1 # if the current element is not 0, set a0 to 1 (move possible)
    j end

  

case2:
    lh t4, 0(t2)             # save previous element's value in t4
    # Traverse the buffer
    bgt t1, a1, end          # If counter exceeds length, exit loop
    lw t2, 0(t0)             # address of the current element of the buffer
    lh t3, 0(t2)             # load the value of the current element of the buffer
    
    # Check if current element is zero
    beq t3, zero, found_zero
    
    # Check if current equals previous (both non-zero)
    beq t3, t4, found_equal
    
    # Move to next element
    mv t4, t3                # update previous value
    addi t0, t0, 4           # move to the next element of the buffer
    addi t1, t1, 1           # increment the counter
    j case2

found_zero:
    # Found a zero - check if it's the last element
    beq t1, a1, end          # If it's the last element, no move possible
    
    # Check if all remaining elements are zeros
    # Save current position
    mv t5, t0                # t5 = current address
    mv t6, t1                # t6 = current counter
    
check_remaining:
    addi t5, t5, 4           # move to next element
    addi t6, t6, 1           # increment counter
    bgt t6, a1, end          # if we've checked all elements and found only zeros, no move possible
    
    lw t2, 0(t5)             # get address of element
    lh t3, 0(t2)             # get value of element
    bne t3, zero, found_nonzero # if non-zero found
    j check_remaining        # continue checking
    
found_nonzero:
    li a0, 1                 # move is possible
    j end

found_equal:
    # Found two adjacent equal non-zero elements
    li a0, 1                 # move is possible
    j end

fail:
    li a0, 0                 # if no move possible, set a0 to 0
    
end: 
    jr ra