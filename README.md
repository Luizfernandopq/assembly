Para montar com o assembler do gcc use:

> as filesource.s -o filetarget.o

> gcc -o programa filetarget.o -nostdlib -static

Para montar com o assembler NASM:

> nasm -f elf64 filesource.asm -o filetarget.o

> ld program.o -o program

Para execução padrão use ./'nome do programa'
