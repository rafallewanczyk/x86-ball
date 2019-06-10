CC = gcc
CFLAGS = -m64 -Wall -no-pie -g

all:	main.o f.o
	$(CC) $(CFLAGS) main.o f.o -o fun `allegro-config --shared`

main.o:	main.c
	$(CC) $(CFLAGS) -c main.c -o main.o

f.o:	f.s
	nasm -f elf64 f.s

clean:
	rm -f *.o
