.text
.globl move_one

#
#	a0 buffer address
#	a1 buffer length
#
#	|----|----|----|----|----|		|----|----|----|----|----|
#	|  2 |  0 |  2 |  0 |  4 |	=> 	|  2 |  2 |  0 |  4 |  0 |
#	|----|----|----|----|----|		|----|----|----|----|----|
#
#	a0 1 iff something changed else 0

move_one:
	li a0 0
	jr ra
