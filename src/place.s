.text
.globl place

# 	a0 board address
# 	a1 board length
#	a2 field number to place into
#	a3 number to place
#
#	a0 == 0 iff place succesfull else 1
#

place:
	li a0 0
    jr ra
