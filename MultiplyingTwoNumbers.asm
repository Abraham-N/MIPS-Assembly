#name: positive number multiplication calculator
	.data	
arg1:	.asciiz "Enter the first number for multiplication:" 
arg2:	.asciiz "Enter the second number for multiplication:" 

	.text
	.globl main
main:
	li 	$v0, 4
	la	$a0, arg1
	syscall
	li	$v0, 5
	syscall	
	add	$s1, $v0, $zero #prompting for first operand and saving to $s1
	
	li 	$v0, 4
	la	$a0, arg2
	syscall
	li	$v0, 5
	syscall	
	add	$t1, $v0, $zero #prompting for second operand and saving to $t1
	addi	$s3, $zero, 0 #initializing $s3
		
	blez	$t1, finlt #branching if either operand is less than 0
	blez	$s1, finlt
	

fori: #loop to perform the multiplication
	add	$s3, $s3, $s1	
	addi	$t1, $t1, -1
	bnez	$t1, fori
			
fin: #branch here after multiplication is complete
	li  $v0, 1  
	add $a0, $s3, $zero
	syscall
	li	$v0, 10
	syscall	

finlt: #branch here if operand less than 0
	li  $v0, 1  
	addi $a0, $zero, 0
	syscall
	li	$v0, 10
	syscall	 
