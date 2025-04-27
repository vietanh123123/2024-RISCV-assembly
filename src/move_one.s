.text
.globl move_one

#
#	a0 buffer address
#	a1 buffer length
#
#	|----|----|----|----|----|		|----|----|----|----|----|
#	|  2 |  0 |  2 |  0 |  4 |	=> 	|  2 |  2 |  0 |  4 |    0 |
#	|----|----|----|----|----|		|----|----|----|----|----|
#
#	a0 1 iff something changed else 0

move_one:
    # Check if length is less than 2, 
    li t0, 2
    blt a1, t0, fail          # If length < 2, no move possible

    mv t0, a0                 # address of  previous tile 
    addi t1, a0, 4            # t1 = address of  current tile 

   
    slli t2, a1, 2            # byte offset 
    add t2, a0, t2            # t2 = address after the last pointer entry

    li a0, 0                  

loop_check_pair:
    # Load address and value of the previous tile 
    lw t3, 0(t0)              # t3 = address of the previous tile
    lh t4, 0(t3)              # t4 = value of the previous tile

    # Load address and value of the current tile 
    lw t5, 0(t1)              # t5 = address of the current tile
    lh t6, 0(t5)              # t6 = value of the current tile

    # Check if the condition (previous == 0 AND current != 0) is met
    bne t4, zero, next_pair   # If previous tile is NOT zero, continue to the next pair
    beq t6, zero, next_pair   # If current tile IS zero, continue to the next pair

    # Condition met: previous tile is 0 and current tile is non-zero
    
    sh t6, 0(t3)              # Store current tile's value (t6) into previous tile's location (t3)
    sh zero, 0(t5)            # Store zero into current tile's location (t5)
    
    li a0, 1                 

next_pair:
    # Advance pointers to the next pair
    addi t0, t0, 4           
    addi t1, t1, 4            

    # Check if we have processed the last possible pair 
   
    blt t1, t2, loop_check_pair # If t1 < address_after_last, continue loop
    
    j end

fail:
   li a0, 0 

end: 
    jr ra                   