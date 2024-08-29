section .data
    message db 'Number: ', 0      ; Mensagem a ser impressa
    number dq 12345               ; Número a ser impresso (64 bits)

section .bss
    buffer resb 20                ; Buffer para armazenar a conversão do número para string

section .text
    global _start

_start:
    ; Escreve a mensagem "Number: "
    mov rax, 1                    ; Syscall para sys_write
    mov rdi, 1                    ; File descriptor (1 = stdout)
    mov rsi, message              ; Endereço da mensagem
    mov rdx, 8                    ; Comprimento da mensagem
    syscall                       ; Chamada do sistema

    ; Converte o número em string
    mov rax, [number]             ; Carrega o número em RAX
    mov rdi, [buffer]               ; Ponteiro para o buffer
    call int_to_string            ; Converte o número para string

    ; Escreve o número convertido
    mov rax, 1                    ; Syscall para sys_write
    mov rdi, 1                    ; File descriptor (1 = stdout)
    mov rsi, [buffer]               ; Endereço do buffer
    mov rdx, rbx                  ; Comprimento da string
    syscall                       ; Chamada do sistema

    ; Syscall para sair (sys_exit)
    mov rax, 60                   ; Syscall para sys_exit
    xor rdi, rdi                  ; Código de saída 0
    syscall                       ; Chamada do sistema

; Função para converter inteiro em string
int_to_string:
    xor rbx, rbx                  ; Limpar RBX (usado como contador de dígitos)
    mov rcx, 10                   ; Base decimal

convert_loop:
    xor rdx, rdx                  ; Limpar RDX (necessário para divisão)
    div rcx                       ; Dividir RAX por 10
    add dl, '0'                   ; Converter o dígito para caractere ASCII
    mov [rdi + rbx], dl           ; Armazenar o caractere no buffer
    inc rbx                       ; Incrementar o contador de dígitos
    test rax, rax                 ; Verificar se RAX é zero
    jnz convert_loop              ; Se não for zero, repetir o loop

    ; Inverte a string no buffer
    mov rcx, rbx                  ; Número de dígitos
    dec rbx                       ; Ajustar para índice (rbx - 1)
    xor rsi, rsi                  ; RSI será o índice de início
reverse_loop:
    cmp rsi, rbx                  ; Verificar se os índices se encontram
    jge reverse_done              ; Se sim, terminar a inversão
    mov al, [rdi + rsi]           ; Carregar o caractere inicial
    mov bl, [rdi + rbx]           ; Carregar o caractere final
    mov [rdi + rsi], bl           ; Colocar o caractere final no início
    mov [rdi + rbx], al           ; Colocar o caractere inicial no final
    inc rsi                       ; Avançar para frente
    dec rbx
    dec rcx                       ; Avançar para trás
    jmp reverse_loop              ; Repetir

reverse_done:
    mov [rdi + rcx], byte 0       ; Adicionar o terminador nulo
    ret
