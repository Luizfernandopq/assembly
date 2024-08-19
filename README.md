Para montar com o assembler do gcc use:

>>> as <filesource>.s -o <filetarget>.o

Para montar com o assembler NASM:

>>> nasm -f elf64 <filesource>.asm -o <filetarget>.o

Para qualquer caso utilize o linker do gcc:

>>> gcc -o programa <filetarget>.o -nostdlib -static
