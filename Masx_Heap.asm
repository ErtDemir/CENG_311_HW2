# ID: 260201059 - Name: Ertuğrul Demir
# I Can not write BFS so I assume BFS 

.data
unorderedList: .word 13, 26, 44, 8, 16, 37, 23, 67, 90, 87, 29, 41, 14, 74, 39, -1

insertValues: .word 46, 85, 24, 25, 3, 33, 45, 52, 62, 17

space: .asciiz " "
newLine: .asciiz "\n"



####################################
#   4 Bytes - Value
#   4 Bytes - Address of Left Node
#   4 Bytes - Address of Right Node
#   4 Bytes - Address of Root Node
####################################

.text 
main:

la $a0, unorderedList


jal build
move $s3, $v0

move $a0, $s3
jal print

li $s0, 8
li $s2, 0
la $s1, insertValues
insertLoopMain: 
beq $s2, $s0, insertLoopMainDone

lw $a0, ($s1)
move $a1, $s3
jal insert

addi $s1, $s1, 4
addi $s2, $s2, 1 
b insertLoopMain
insertLoopMainDone:

move $a0, $s3
jal print


move $a0, $s3
jal remove


move $a0, $s3
jal print


li $v0, 10
syscall 


########################################################################
# Write your code after this line
########################################################################


####################################
# Build Procedure
####################################
build:

 	move    $t5, $a0
    move    $t6, $a0

    addi    $sp, $sp, -4
    sw      $ra, 0($sp)

build_loop:  
    lw      $t7, 0($t6)
    beq		$t7, -1, build_loop_done

    move    $a0, $t7
    jal     insert
    add     $t6, $t6, 4
    j       build_loop

build_loop_done:
    move    $a0, $t5

    lw      $ra, 0($sp) 
    addi    $sp, $sp, 4

    jr $ra


jr $ra

####################################
# Insert Procedure
####################################
insert: #(int)

	subu $sp, $sp, 4 
    sw   $a0, 0($sp)
	
	li $v0, 9
	li $a0, 12
	syscall
	
	lw   $a0, 0($sp)
	addu $sp, $sp, 4 
	li $t1 , 1 		# height

	
	nextLeft:
		lw $t0, 4($a1)
		beq $t0, $zero,nextLeftDone
		move $a2, $a1
		lw $a1, 4($a1)
	nextRight:
		lw $t0, 8($a1)
		beq $t0, $zero,nextRightDone
		move $a2, $a1
		lw $a1, 8($a1)
		b nextLeft
	nextLeftNodeDone:
		sw $v0, 4($a1)
		sw $zero, 4($v0)
		sw $zero, 8($v0)
		sw $a2, 12($v0)
		sw $a0, 0($v0)

	nextRightNodeDone:
		sw $v0, 8($a1)
		sw $zero, 4($v0)
		sw $zero, 8($v0)
		sw $a2, 12($v0)
		sw $a0, 0($v0)

	# I tried to write BFS but I couldn't

	

jr $ra

####################################
# Remove Procedure
####################################
remove:



jr $ra

####################################
# Print Procedure
####################################
print:

subu $sp, $sp, 4 
sw   $a0, 0($sp)
	
li $v0, 1
lw $a0, 0($a0)
syscall

li $v0, 4
la $a0, space
syscall
	
lw   $a0, 0($sp)
addu $sp, $sp, 4 
li $t1 , 1 		# height

# This function must contain BFT in this line

print_done:
	li $v0, 4
	la $a0, newLine
	syscall


jr $ra

####################################
# Extra Procedures
####################################

swap: # a2 - inserted item

	lw $t5, 12($a2) # $t5 is parent node 
	bgr 0($t5), 0($a2),do_swap
	jal end_swap
	
	do_swap:
		lw $t2, 4($a2)	 # Stored child node's adresses in temps
		lw $t3, 8($a2)
		lw $t4, 12($a2)

		lw $t6, 4($t5)   # Stored parent node's adresses in temps
		lw $t7, 8($t5)
		lw $t8, 12($t5)

		sw $t2, 4($t5)	# Save child inf. to parent
		sw $t3, 8($t5)
		sw $t4, 12($t5)

		sw $t6,4($a2)	# Save parent inf. to child
		sw $t7,8($a2)
		sw $t8,12($a2)

		jal swap

		

end_swap:

jr $ra