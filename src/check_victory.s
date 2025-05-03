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
   mv t2, a0 # Adress of the first field 
   li a0, 0
loop: 
    bgt t1, a1, end # If counter > length of board, exit loop
    lh t3, 0(t2) 
    beq t3, t0, found # If 2048 found, set a0 to 1
    addi t2, t2, 2
    addi t1, t1, 1
    j loop 

found: 
   li a0 1 

end: 
   jr ra      