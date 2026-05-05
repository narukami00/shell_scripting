CC = gcc
CFLAGS = -Wall -g
TARGET = program
OBJS = main.o add.o sub.o

# The default target that gets built when you just run 'make'
all: $(TARGET)
# grep -rn "#include"
# Rule to link the object files into the final executable
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS)

# Rules to compile .c files into .o (object) files
main.o: main.c add.h sub.h
	$(CC) $(CFLAGS) -c main.c

add.o: add.c add.h
	$(CC) $(CFLAGS) -c add.c

sub.o: sub.c sub.h
	$(CC) $(CFLAGS) -c sub.c

# Clean rule to remove compiled files
clean:
# Note: On native Windows without Unix tools, use "del /Q /F *.o $(TARGET).exe" instead
	rm -f $(OBJS) $(TARGET) $(TARGET).exe
