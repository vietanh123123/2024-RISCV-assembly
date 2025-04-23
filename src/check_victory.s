.text
.globl check_victory


#
#	a0 board address
#	a1 board length
#
#	a0 == 1 iff 2048 found
#

check_victory:
   li t0, 2048
   li t1 1  # Counter for length of board
   add t2 a0 zero   # Counter for array index
   lh t3 0(a0) # Load first element of board
   li a0 0 
   

loop: 
    bgt t1 a1 end # If counter is greater than length of board, exit loop
    beq t3 t0 found # If current element is equal to 2048, set a0 to 1 and exit loop
    addi t2 t2 2 # Increment by 2 for halfword
    addi t1 t1 1 # Increment counter
    lh t3 0(t2) # Load next element of board
    j loop # Jump to loop

found: 
   li a0 1 

end: 
   jr ra      