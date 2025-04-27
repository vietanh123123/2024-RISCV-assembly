.data
.globl printboard

# String constants for printing
horizontal: .string "-----------------------------\n"
vertical_small: .string "|"
empty_space: .string "      "
space1: .string " "
space2: .string "  "
space3: .string "   "
space4: .string "    "
space5: .string "     "
space6: .string "      "
newline: .string "\n"

#
#a0 Address of the first field of the board
#
#	-----------------------------
#	|      |      |      |      |
#	| 2048 |  128 |    8 | 1024 |
#	|      |      |      |      |
#	-----------------------------
#	|      |      |      |      |
#	| 1024 |   64 |    4 |    8 |
#	|      |      |      |      |
#	-----------------------------
#	|      |      |      |      |
#	|  512 |   32 |  512 |  128 |
#	|      |      |      |      |
#	-----------------------------
#	|      |      |      |      |
#	|  256 |   16 | 2048 | 1024 |
#	|      |      |      |      |
#	-----------------------------
#
.text
printboard:
  li t1, 1 #Row counter
  mv t0 , a0 #Copy the address of the first field of the board to t0

loop_each_row:
    li t6, 5
    beq t1, t6, end    #Done 
    #Print the horizontal line
    li a0, 4
    la a1 horizontal
    ecall #print horizontal line

    la a1 vertical_small 
    ecall

    la empty_space
    ecall 

    la a1 vertical_small 
    ecall

    la empty_space
    ecall 

    la a1 vertical_small 
    ecall

    la empty_space
    ecall 

    la a1 vertical_small 
    ecall

    la empty_space
    ecall 

    la a1 vertical_small
    ecall

    la a1 newline
    ecall

    la a1 vertical_small
    ecall 
    
    lh t2, 0(t0) #Load the value of the first field of the board
    bgt t2, 2000, print_2048 #If the value is greater than 2000, print 2048
    gbt t2, 1000, print_1024 #If the value is greater than 1000, print 1024
    bt t2, 100 , print_128_256_512_ #If the value is greater than 100, print 128, 256 or 512
    bgt t2, 10, print_16_32_64_ #If the value is greater than 10, print 16, 32 or 64

print_0_2_4_8:
   
  
print_2048:


print_1024:

print_128_256_512_:


print_16_32_64_:


end :
   jr ra







