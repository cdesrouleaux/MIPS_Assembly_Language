.data

print: .asciiz "Enter 4 integers for A, B, C, D respectively: \n"
nl: .asciiz "\n"
f10: .asciiz "f_ten = "
g10: .asciiz "g_ten = "
hq: .asciiz "h_quotient = "
hr: .asciiz "h_remainder = "
im: .asciiz "i_mod = "


.text

# construct a header...

# Jean Desrouleaux - 06/17/2024
# Project1b - computed the output of the arithmitic solutions f = ( 5 * B * D + A )  and g = ( D * D– C * A )
# leaving the results of f and g in registers $s0 and $s2 respectivly
# Registers Used: 
# $s7 - counter
# $s0, $s1, $s2, $s3 each containing a mid step of the arithmitic solution
#
# reads inputs from user for: A=$t0, B=$t1, C=$t2, D=$t3
li $v0, 4
la $a0, print 	# prints input instructions
syscall

# accepts user inputs $t0-$t3
li $v0, 5
syscall
move $t0, $v0
li $v0, 5
syscall
move $t1, $v0
li $v0, 5
syscall
move $t2, $v0
li $v0, 5
syscall
move $t3, $v0


li $s0, 0 # presetting setting value to 0
li $s7, 0 # counter set to 0
loop1a:
add $s0, $s0, $t1 # math 
add $s7, $s7, 1
bne $s7, 5, loop1a # runs 5 times

li $s1, 0 # presetting setting value to 0
li $s7, 0 # counter set to 0
loop1b:
add $s1, $s1, $t3 # math 
add $s7, $s7, 1
bne $s7, $s0, loop1b # runs the (5*B) number of times 

add $s0, $s1, $t0 # adds (5*B*D) + A


li $v0, 4	
la $a0, f10	# outputs base 10 integer value
syscall
li $v0, 1
move $a0, $s0
syscall

# new line 
li $v0, 4
la $a0, nl
syscall


li $s2, 0 # presetting setting value to 0
li $s7, 0 # counter set to 0
loop2a:
add $s2, $s2, $t3
add $s7, $s7, 1
bne $s7, $t3, loop2a # runs the (D*D) number of times 

li $s3, 0 # presetting setting value to 0
li $s7, 0 # counter set to 0
loop2b:
add $s3, $s3, $t2
add $s7, $s7, 1
bne $s7, $t0, loop2b # runs the (C*A) number of times 

subu $s2, $s2, $s3 # substracts (D*D)-(C*A) unsigned to eliminate potential negative answers 

li $v0, 4	
la $a0, g10	# outputs base 10 integer value
syscall
li $v0, 1
move $a0, $s2
syscall

# new line 
li $v0, 4
la $a0, nl
syscall

# exit
li $v0, 10	# exit
syscall
