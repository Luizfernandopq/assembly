.text

.globl main
main:
	li $2, 5
	syscall

	addi $4, $2, 0
	li $2, 1
	syscall	

	li $2, 10
	li $4, 0
	syscall
