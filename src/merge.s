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
     # Adress of the last element  since we just merge pairs = (a1 - 1) * 2 + a
    mv t0, a0   #t0 holds the base address
    addi t1, a1, -1
    li t4, 2
    mul t1, t1, t4 
    add t1, t1, a0 #t1 holds the address of the last element
check:
    beq t0, t1, end # if t0 == t1, we are done
    
    # we merge if the pair is equal and none of the elements is 0
    lh t2 , 0(t0)  #t2 holds the first element
    lh t3 , 2(t0)  #t3 holds the second element
    beq t2, zero, go_next # if t2 == 0, skip to next pair
    beq t3, zero, go_next # if t3 == 0, skip to next pair
    bne t2, t3, go_next # if t2 != t3, skip to next pair 
    
    # merge the pair 
    add t2, t2, t3 # t2 holds the new value
    sh t2, 0(t0) # store the new value in the first element
    sh zero, 2(t0) # set the second element to 0

    # Check if this is the last pair 
    addi t4, t0, 4 
    beq t4, t1, end # if t4 == t1, we are done

    addi t0, t0, 4 # move to the next pair
    j check # jump to check again


go_next: 
    addi t0, t0, 2
    j check # jump to check again

end:
      
    jr ra