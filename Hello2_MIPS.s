.data
message: .asciiz "Hello, World!"

.text
.globl main
main:
    li $2, 4          # syscall para print_str
    la $4, message    # carregar endereço da mensagem
    syscall            # chamar o sistema para imprimir

    li $8, 10
    li $2, 10         # syscall para exit
    syscall            # sair do programa
