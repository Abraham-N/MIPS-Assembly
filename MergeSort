#Abraham Nofal
#AMN170002
	.data	
prompt1:.asciiz "Enter the number of integers in the array: " 	
prompt2:.asciiz "Enter each integer one at a time contained in the array, press enter after each one: "
space:	.asciiz " " 
arg1:   .space 	 100     		#store for the first array of unsorted integers
arg1s:  .space 	 1    			#length of the  list
result: .word    0:100			#merged list will be stored here, input is 
	.text

#main takes the size of the array from the user, as well as display the above prompts.
main:
	li 	$v0, 4
	la	$a0, prompt1
	syscall				#prompting for number of integers contained in array (arr.size)	
	li	$v0, 5
	syscall	
	add	$s0, $v0, $zero 	#saving arr.size to $s0
	add 	$t0, $s0, $zero		#saving arr.size to temporary variable
	li 	$v0, 4
	la	$a0, prompt2
	syscall				#prompting for integers contained in unsorted array
	la 	$s1, arg1		#$s1 will hold the address for the unsorted array.
	
#SA is short for store array. This is where the integers of the array are collected from user and stored into memory for access by MergeSort
SA:
	li	$v0, 5
	syscall	
	sw	$v0, 0($s1)		#store the integer in the array
	addi	$s1, $s1, 4		#move to next index of array
	addi 	$t0, $t0, -1		#subtract one from the size 
	bgt 	$t0, $zero, SA		#if size reaches 0, we have added all integers to array, otherwise, repeat until size is met
	
#premerge initializes variables before beginning the MergeSort recursion.
premerge:	
	la 	$a0, arg1		#store address of the array in $a0
	addi 	$a1, $s0, -1		#$a1 will be the high index used for the merge sort
	addi 	$a2, $zero, 0 		#$a2 will be the low index used for the merge sort	
	jal 	func			#begin the Merge Sort algorithm		
	j 	fin1			#jump to printlist to print the sorted array and close the program
#func and consequent loops implement the generic recursive merge sort algorithm using MIPS
func:
	slt 	$t0, $a2, $a1 		#return if low > high 
	beq 	$t0, $zero, return	#
	addi 	$sp, $sp, -16 		#4 things must be saved on stack:
	sw 	$a1, 4($sp)        	#• high
	sw 	$a2, 8($sp)	       	#• low	
	sw 	$ra, 12($sp)		#• return address
	add 	$t1, $a1, $a2		#calculate the value of mid by adding low and high
	sra 	$t1, $t1, 1		#then dividing by 2 (shifting one bit to the right). $s0 holds the value of mid
	sw 	$t1, 0($sp) 		#• mid	
	add 	$a1, $t1, $zero 	#high = mid
	jal 	func			#begin recursion with high = mid (left side of array)
	lw 	$t1, 0($sp)		#retrieve mid from the stack
	addi 	$t2, $t1, 1		#add one to it
	add 	$a2, $t2, $zero 	#low = mid + 1
	lw 	$a1, 4($sp) 		#retrieve high from the stack
	jal 	func			#recursive call to MergeSort with low = mid + 1 (right side of array)
	lw 	$a3, 0($sp) 		#retrieve mid from stack
	lw 	$a1, 4($sp)  		#retrieve high from stack
	lw 	$a2, 8($sp) 		#retrieve low from the stack
	jal 	merge			#function call to merge					
	lw 	$ra, 12($sp)		#retrieve $ra from the stack
	addi 	$sp, $sp, 16 		#reset stackpointer by same offset
	jr  	$ra			#return to return address from stack
return:
	jr 	$ra			#return to caller
merge:
	add  	$t0, $a2, $zero 	#initialize two low variables: $t0
	add  	$t1, $a2, $zero 	#and $t1
	addi 	$t2, $a3, 1  		#initialize $t2 as mid + 1
loop:	
	bgt  	$t2, $a1, loop1		#if $t2 > high go to loop1
	bgt  	$t0, $a3, loop1		#if $t0 > mid go to loop2
	sll 	$s0, $t0, 2		#change $t0 (originally low) from an index to an offset ($t0*4)
	add  	$s0, $s0, $a0		#$s0 = address of arr[$t0]
	lw 	$s1, 0($s0)		#$s1 = arr[$t0]
	sll 	$s2, $t2, 2		#change $t2 (originally mid + 1) from an index to an offset ($t2*4)
	add  	$s2, $s2, $a0		#$s0 = address of arr[$t2]
	lw 	$s3, 0($s2)		#$s3 = arr[$t2]
	bgt	$s1, $s3, switch	#if arr[low] > arr[mid + 1], then we must switch them in the final array for it to be sorted
	la   	$s4, result		#load address of result array
	sll  	$s5, $t1, 2		#change $t1 (originally low) from an index to an offset
	add  	$s4, $s4, $s5		#$s3 = address of result[$t1]
	sw   	$s1, 0($s4)		#result[$t1] = arr[$t0]
	addi 	$t0, $t0, 1		#increment both indexes that are originally the low index
	addi 	$t1, $t1, 1	
	j   	loop			#repeat loop with incremented indexes
switch:	
	sll  	$s2, $t2, 2		#change $t2 from index to offset
	add 	$s2, $s2, $a0		#$s2 = address of arr[$t2]
	lw   	$s3, 0($s2)		#$s3 = arr[$t2]
	la   	$s4, result		#load address of result
	sll 	$s5, $t1, 2		#change $t1 to an offset from index
	add  	$s4, $s4, $s5		#$s4 = address of result[$t1]
	sw   	$s3, 0($s4)		#result[$t1] =  arr[$t2]
	addi 	$t2, $t2, 1		#increment $t1
	addi 	$t1, $t1, 1		#increment $t2
	j   	loop			#repeat loop with incremented indexes
loop1:
	bgt 	$t0, $a3, loop2 	#if $t0 (originally low) becomes greater than mid, branch to next loop
	sll	$s0, $t0, 2		#change $t0 (originally low) from index to offset
	add 	$s0, $s0, $a0		#$s0 = address of arr[$t0]
	lw 	$s1, 0($s0)		#$s1 = arr[$t0]
	la  	$s2, result		#load the address of result array
	sll 	$s3, $t1, 2     	#change $t1 from an index to an offset
	add 	$s3, $s2, $s3		#$s3 = address of result[$t1]
	sw 	$s1, 0($s3) 		#result[$t1] = arr[$t0]
	addi 	$t1, $t1, 1   		#increment both indexes
	addi 	$t0, $t0, 1   		
	j 	loop1			#repeat until condition is met
loop2:
	bgt  	$t1, $a1, preloop3	#if $t1 becomes > high then go to next loop
	sll 	$s2, $t2, 2    		#change $t2 from an index to an offset
	add 	$s2, $s2, $a0  		#$s2 = address of arr[$t2]
	lw 	$s3, 0($s2)     	#$s3 = arr[$t2]
	la  	$s4, result		#$s4 is the address of result array
	sll 	$s5, $t1, 2	   	#change $t1 from an index to an offset
	add 	$s4, $s4, $s5  		#$s4 = address of result[$t1]
	sw 	$s3, 0($s4)     	#result[$t1] = arr[$t2]
	addi 	$t1, $t1, 1   		#increment both indexes
	addi 	$t2, $t2, 1   		#
	j 	loop2			# Go to next iteration
preloop3:
	add  	$s0, $a2, $zero		#$s0 = low
	addi 	$s1, $a1, 1 		#$s1 = high + 1
	la   	$s4, result		#$s4 = address of result
loop3:
	slt 	$s7, $s0, $s1  		#If low > high, go to fin
	beq 	$s7, $zero, fin		
	sll 	$s2, $s0, 2   		#change $s0 from an index to an offset
	add 	$s3, $s2, $a0		#$s3 = address of arr[$s0]
	add 	$s5, $s2, $s4		#$s5 = address of result[$s0]
	lw  	$s6, 0($s5)		#$s6 = result[$s0]
	sw 	$s6, 0($s3)   		#arr[$s0] = result[$s0]
	addi	$s0, $s0, 1 		#increment the index
	j 	loop3			#repeat until result is copied to array
fin:
	jr 	$ra			# return to the caller function		
#After merge sort has finished, fin1 will be run from main to print the list.
fin1:
   	addi 	$t0 $zero, 0		#$t0 = indexing variable for result
    	la 	$s4, result		#$s4 = address of the result list
    	add 	$t1, $s0, $zero		#$t0 = arr.size
printlist:
    	beq 	$t0, $t1, fin2		#if all numbers have been printed (index counter = length of result), branch to fin2 
    	lw 	$a0, 0($s4)		#otherwise load the current number in list to $a0
    	li 	$v0, 1			#load system call for print int
    	syscall				#print the integer
    	li 	$v0, 4
	la	$a0, space
	syscall	
    	addi 	$s4, $s4, 4		#increment address of result list to the next integer
    	addi 	$t0, $t0, 1		#increment indexing variable
    	j 	printlist		#repeat until all numbers are printed.
fin2:	
    	li 	$v0, 10			#load exit system call
    	syscall				#exit

