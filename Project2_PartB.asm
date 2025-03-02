# Jean Desrouleaux -- 07/01/2024
# Project2_PartB.asm - OPTMIZED CODE -  This program takes a the input of a user string and counts how many times the characters K,N,I,G,H,T,S
# are found and outputs this result as both integer values and a histogram chart
#
# Registers used:
# $t0 - saves the input string in memory
# $k1 - holds a single word (1 word = 4 bytes) from the string input
# $s0 - counter for number of K characters found in string input
# $s1 - counter for number of N characters found in string input
# $s2 - counter for number of I characters found in string input
# $s3 - counter for number of G characters found in string input
# $s4 - counter for number of H characters found in string input
# $s5 - counter for number of T characters found in string input
# $s6 - counter for number of S characters found in string input
# $s7 - counter to the $s0-s7 loops
#
# Predefined Variables:
# print: -  "Print string:\n" 
# nl: - "\n" - new line
# k: - "K: " - holds ascii value of K
# n: - "N: " - holds ascii value of N
# i: - "I: " - holds ascii value of I
# g: - "G: " - holds ascii value of G
# h: - "H: " - holds ascii value of H
# t: - "T: " - holds ascii value of T
# s: - "S: " - holds ascii value of A
# buffer: .space 500 - holds number of bytes in we would like to make space for 
# hash: - "#" - holds ascii value of #



.data

print: .asciiz "Print string:\n"
nl: .asciiz "\n"
k: .asciiz "K: "
n: .asciiz "N: "
i: .asciiz "I: "
g: .asciiz "G: "
h: .asciiz "H: "
t: .asciiz "T: "
s: .asciiz "S: "
buffer: .space 512
hash: .asciiz "#"

.text

# user instructions
li $v0, 4
la $a0, print
syscall


# user input - "memory is byte addressable"
li $v0, 8 # takes input 

la $a0, buffer # controls size of memory allocation in bytes
li $a1, 1024 # limits number of characters from user input

move $t0, $a0 # save string to $t0
syscall

# prints new line
li $v0, 4
la $a0, nl
syscall



# letter counting registers are preset to 0
li $s0, 0 # K,k
li $s1, 0 # N,n
li $s2, 0 # I,i
li $s3, 0 # G,g
li $s4, 0 # H,h
li $s5, 0 # T,t
li $s6, 0 # S,s


# begining of loop
loop:

lb $k1, 0($t0) # loads the data at the current memory location into a register to be later used for comparision
beqz $k1, exit # if reg $k1 = NULL (comparator register) exit the loop we have reached the end of the string

### CODE OPTMIZATION ###

# checks if any of the letters in KNIGHTS upper or lower are found in current byte address if so branch to the respective location
beq $k1, 75, K	#K
beq $k1, 107, K	#k
beq $k1, 78, N	#N
beq $k1, 110, N	#n
beq $k1, 73, I	#I
beq $k1, 105, I	#n
beq $k1, 71, G	#G
beq $k1, 103, G	#g
beq $k1, 72, H	#H
beq $k1, 104, H	#h
beq $k1, 84, T	#T
beq $k1, 116, T	#t
beq $k1, 83, S	#S
beq $k1, 115, S	#s

### CODE OPTMIZATION ###

j skip # if no branch condition is met loop itterates to the next word

# If the above code finds a matching letter in our string than code branches to a location K,N,I,G,H,T,S.
# Once code branches down to this serries of branches these branches each adds 1 to the respective counter which keep 
# track of how many K, N, I, G, H, T, S are found in the input string.
# After the code branches down into this serries of branch statements, the statement ends by jumping to the skip branch
# in order to avoid executing the remainder of the branch statements which keeps the counters accurate.
K:
addi $s0, $s0, 1 
j skip

N:
addi $s1, $s1, 1
j skip

I:
addi $s2, $s2, 1
j skip

G:
addi $s3, $s3, 1
j skip

H:
addi $s4, $s4, 1
j skip

T:
addi $s5, $s5, 1
j skip

S:
addi $s6, $s6, 1
j skip

skip:
# add 4 bits to our current word to move on to the next character
addi $t0, $t0, 1  # moves to the next memory location +1 byte

j loop # if no exit condition is met jumps back to the begining of loop

exit:
# end of loop

# the number of K, N, I, G, H, T, S are found in the input string are outputed using syscall instrucitons
li $v0, 4
la $a0, k
syscall
li $v0, 1
move $a0, $s0 	#K,k
syscall
li $v0, 4
la $a0, nl
syscall

li $v0, 4
la $a0, n
syscall
li $v0, 1
move $a0, $s1 	#N,n
syscall
li $v0, 4
la $a0, nl
syscall

li $v0, 4
la $a0, i
syscall
li $v0, 1
move $a0, $s2	#I,i
syscall
li $v0, 4
la $a0, nl
syscall

li $v0, 4
la $a0, g
syscall
li $v0, 1
move $a0, $s3	#G,g
syscall
li $v0, 4
la $a0, nl
syscall

li $v0, 4
la $a0, h
syscall
li $v0, 1
move $a0, $s4	#H,h
syscall
li $v0, 4
la $a0, nl
syscall

li $v0, 4
la $a0, t
syscall
li $v0, 1
move $a0, $s5	#T,t
syscall
li $v0, 4
la $a0, nl
syscall

li $v0, 4
la $a0, s
syscall
li $v0, 1
move $a0, $s6	#S,s
syscall
li $v0, 4
la $a0, nl
syscall


li $v0, 4
la $a0, nl
syscall

####
#### Next part off the code outputs the values the K,N,I,G,H,T,S counters as a histogram
####

# To output a histogram we use a preset "hash=#" variable and a loop to print a number of hash marks equivalent to the number of 
# letters we find in our string. As were know the number of the letters K,N,I,G,H,T,S are held in registers $s0-$s6. These outputs 
# are represented as hash marks like a histogram.
li $v0, 4
la $a0, k
syscall
li $s7, 0 # set counter = 0
# loops until $s7 = $s0
loopK:
beqz $s0, skipK
addi $s7, $s7, 1

li $v0, 4
la $a0, hash
syscall

bne $s7, $s0, loopK
skipK:

li $v0, 4
la $a0, nl # skips line between outputs
syscall



li $v0, 4
la $a0, n
syscall
li $s7, 0 # set counter = 0
# loops until $s7 = $s1
loopN:
beqz $s1, skipN
addi $s7, $s7, 1

li $v0, 4
la $a0, hash
syscall

bne $s7, $s1, loopN
skipN:

li $v0, 4
la $a0, nl # skips line between outputs
syscall



li $v0, 4
la $a0, i
syscall
li $s7, 0 # set counter = 0
# loops until $s7 = $s2
loopI:
beqz $s2, skipI
addi $s7, $s7, 1

li $v0, 4
la $a0, hash
syscall

bne $s7, $s2, loopI
skipI:

li $v0, 4
la $a0, nl # skips line between outputs
syscall



li $v0, 4
la $a0, g
syscall
li $s7, 0 # set counter = 0
# loops until $s7 = $s3
loopG:
beqz $s3, skipG
addi $s7, $s7, 1

li $v0, 4
la $a0, hash
syscall

bne $s7, $s3, loopG
skipG:

li $v0, 4
la $a0, nl # skips line between outputs
syscall



li $v0, 4
la $a0, h
syscall
li $s7, 0 # set counter = 0
# loops until $s7 = $s4
loopH:
beqz $s4, skipH
addi $s7, $s7, 1

li $v0, 4
la $a0, hash
syscall

bne $s7, $s4, loopH
skipH:

li $v0, 4
la $a0, nl # skips line between outputs
syscall



li $v0, 4
la $a0, t
syscall
li $s7, 0 # set counter = 0
# loops until $s7 = $s5
loopT:
beqz $s5, skipT
addi $s7, $s7, 1

li $v0, 4
la $a0, hash
syscall

bne $s7, $s5, loopT
skipT:

li $v0, 4
la $a0, nl # skips line between outputs
syscall



li $v0, 4
la $a0, s
syscall
li $s7, 0 # set counter = 0
# loops until $s7 = $s6
loopS:
beqz $s6, skipS
addi $s7, $s7, 1

li $v0, 4
la $a0, hash
syscall

bne $s7, $s6, loopS
skipS:

li $v0, 4
la $a0, nl # skips line between outputs
syscall



# exit
li $v0, 10
syscall