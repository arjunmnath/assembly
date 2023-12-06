source ?= ""
out ?= out


nasm-ld:
	nasm -felf64 $(source) -o a.o;
	ld a.o -o $(out);
	rm a.o;

nasm-gcc:
	nasm -felf64 $(source) -o a.o;
	gcc -o $(out) a.o;
	rm a.o;

as-gcc:
	as $(source);
	gcc a.out -0 $(out) -nostdlib -static;
	rm a.out;


