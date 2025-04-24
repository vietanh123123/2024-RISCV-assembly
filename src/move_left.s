.text
.globl move_left
.import "move_one.s"


#
#	a0 buffer address
#	a1 buffer length
#
#	|----|----|----|----|		|----|----|----|----|
#	|  0 |  2 |  0 |  4 |	=> 	|  2 |  4 |  0 |  0 |
#	|----|----|----|----|		|----|----|----|----|
#



move_left:
    add t0 a0 zero # temporary pointer to the first tile
    jal move_one 

    beq a0 zero end # if no move was made, return 0
    add a0 t0 zero # return the address of the first tile
    j move_left


end: 
  jr ra    
