section .data
    value dq 112

section .bss
    buffer resb 5

section .text
    global _start

_start:

	; incrementa
    mov rax, [value]
    add rax, 1      
    mov [value], rax


    ; Exibir o valor convertido
    mov rax, 1                      ; syscall número para sys_write
    mov rdi, 1                      ; file descriptor 1 (stdout)
    lea rsi, [value]               ; Ponteiro para o buffer
    mov rdx, 5                      ; Comprimento da string (ajuste conforme necessário)
    syscall                         ; Chamada de sistema

    ; Sair do programa
    mov rax, 60                     ; syscall número para sys_exit
    xor rdi, rdi                    ; Código de saída 0
    syscall                         ; Chamada de sistema

; Função para converter inteiro para string ASCII
int_to_ascii:
    mov rbx, 10                     ; Base decimal
    xor rcx, rcx                    ; Contador de dígitos
    mov rsi, rdi                    ; Salvar o ponteiro do buffer em RSI

convert_loop:
    xor rdx, rdx                    ; Limpar RDX
    div rbx                         ; Dividir RAX por 10
    add dl, '0'                     ; Converter dígito para caractere ASCII
    mov [rsi + rcx], dl             ; Armazenar caractere no buffer
    inc rcx                         ; Incrementar contador de dígitos
    test rax, rax                   ; Verificar se o valor é zero
    jnz convert_loop                ; Se não for zero, continuar
    ; Adicionar o terminador nulo
	mov byte [rsi + rcx], 0x0A
	inc rcx
    mov byte [rsi + rcx], 0        
   	ret
