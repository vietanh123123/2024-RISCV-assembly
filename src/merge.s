.text
.globl merge
# a0 buffer address
# a1 buffer length
#
# |----|----|----|----| => |----|----|----|----| 
# |  2 |  2 |  0 |  4 |    |  4 |  0 |  0 |  4 | 
# |----|----|----|----| => |----|----|----|----| 
#
#   BONUS: Return the number of merges in a0 and the
#          total base score of the merges in a1.

merge:
    # Handle edge case: Need at least 2 elements to merge
    li t6, 2
    blt a1, t6, end
    
    li t0, 1   # Counter for elements in the buffer
    mv t1, a0  #Buffer address

check:
    beq t0, a1, end
    
    # we merge if the pair is equal and none of the elements is 0
    lw t2 , 0(t1) # Address of the first element of the pair
    lw t3 , 4(t1) #  Address of the second element of the pair
    lh t4 , 0(t2) # load the value of the first element of the pair
    lh t5 , 0(t3) # load the value of the second element of the pair
    beq t4, zero, go_next # if the first element is 0, go to the next pair
    beq t5, zero, go_next # if the second element is 0, go to the next pair
    bne t4, t5, go_next # if the two elements are not equal, go to the next pair

    
    # merge the pair 
    add t4, t4, t5 # add the two elements
    sh t4, 0(t2) # store the result in the first element of the pair
    sh zero, 0(t3) # set the second element of the pair to 0
    


go_next: 
    addi t0, t0, 1
    addi t1, t1, 4 # move to the next pair
    j check # jump to check again

end:
      
    jr ra
