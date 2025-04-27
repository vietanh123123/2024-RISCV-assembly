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
    li t1 1 # t1 = 1 (counter for elements in the buffer)
    
    li a0 , 0 # a0 = 0 (default value for no move possible)
    
    lw t2 , 0(t0) # address of the first element of the buffer
    lh t3 , 0(t2) # load the value of the first element of the buffer
    
    addi t0, t0, 4 # move to the next element of the buffer
    bne t3, zero, case2 # if the first element is not 0, go to case2

case1:    
     # Traverse until we get a non-zero element otherwise return 0
    bgt t1, a1, end # If counter exceeds length, exit loop
    lw t2 , 0(t0) # address of the current element of the buffer
    lh t3 , 0(t2) # load the value of the current element of the buffer
    addi t0 , t0, 4 # move to the next element of the buffer
    beq t3, zero, case1 # if the current element is 0, loop again 
    li a0 , 1 # if the current element is not 0, set a0 to 1 (move possible)
    j end

  

case2:
    # Traverse until we get a zero before last element otherwise return 0
    bgt t1, a1, end # If counter exceeds length, exit loop
    lw t2 , 0(t0) # address of the current element of the buffer
    lh t3 , 0(t2) # load the value of the current element of the buffer
    addi t0 , t0, 4 # move to the next element of the buffer
    bne t3, zero, case2 # if the current element is not 0, loop again

    # Check if this 0 is the last element
    beq t1, a1, end # If counter equals length, exit loop
    li a0 , 1 # if the current element is 0, set a0 to 1 (move possible)
    j end


fail:
    li a0 , 0 # if no move possible, set a0 to 0
end: 
   jr ra
