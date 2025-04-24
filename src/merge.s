.text
.globl merge

#
#	a0 buffer address
#	a1 buffer length
#
#	|----|----|----|----|		|----|----|----|----|
#	|  2 |  2 |  0 |  4 |  => 	|  4 |  0 |  0 |  4 |
#	|----|----|----|----|		|----|----|----|----|
#
#   BONUS: Return the number of merges in a0 and the
#          total base score of the merges in a1.

merge:
    # Handle edge case: Need at least 2 elements to merge
    li t5, 2
    blt a1, t5, end

  

    li t0, 0              # Initialize counter to 0 
    addi t5, a1, -1       # Set t5 to length - 1 
                          
loop:
    bge t0, t5, end       # If counter  >= length-1, end 
                          
    
    lh t1, 0(a0)          
    lh t2, 2(a0)          

    
    beq t1, zero, next_pair
    
    beq t2, zero, next_pair

    bne t1, t2, next_pair
   

    #merge
    add t1, t1, t2        
    sh t1, 0(a0)          
    sh zero, 2(a0)        
   

next_pair:
    # Advance to the next pair
    addi t0, t0, 1        
    addi a0, a0, 2       
    j loop               

end:
    
    
    jr ra