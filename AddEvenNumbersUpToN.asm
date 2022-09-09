	.data	
N:	.asciiz "Enter the value of N: " 
invalid:.asciiz "N < 0, invalid for this program!\n"
result:	.word	0

	.text
	.globl 	main
main:
	li 	$v0, 4
	la	$a0, N
	syscall
	li	$v0, 5
	syscall	
	add	$t1, $v0, $zero #prompting for N and saving to $t1
	la	$t2, result	#$t2 is address of result
	
	addi 	$s3, $zero, 0	#initialize $s3 for the result
	addi 	$s2, $zero, 2	#initialize $s2 = 2 for addition
	blt	$t1, $zero, finlt0  #if N < 0 , branch to finlt0
	blt	$t1, $s2, finlt2   #if N < 2 , branch to finlt2
	
fori:				 #executes if N >= 2
	add 	$s3, $s2, $s3	#add $s2 to $s3, and save in $s3 
	addi	$s2, $s2, 2	#add 2 to $s2 for the next even number (2,4,6,8,10.etc)
	bgt	$s2, $t1, fin	#if $s2 > N, branch to fin
	ble	$s2, $t1, fori	#if $s2 <= N, continue loop
	
fin: 				#if N >= 2
	sw	$s3, 0($t2)	#save the sum to result
	li  	$v0, 1  
	add 	$a0, $s3, $zero	
	syscall			#display the sum
	li	$v0, 10
	syscall			#exit
	
finlt2:				#if 0 <= N < 2 
	sw	$zero, 0($t2)	#save 0 to result
	li  	$v0, 1  
	add 	$a0, $zero, $zero
	syscall			#display result (0)
	li	$v0, 10
	syscall			#exit

finlt0:				#if N < 0
	addi	$s4, $zero, -1 	#$s4 = -1
	sw	$s4, 0($t2)	#save -1 to result
	li 	$v0, 4
	la	$a0, invalid	
	syscall			#display the invalid prompt
	li  	$v0, 1  
	add 	$a0, $s4, $zero
	syscall			#display result (-1)
	li	$v0, 10
	syscall			#exit
	