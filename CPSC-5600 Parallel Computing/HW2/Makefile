CPPFLAGS = -std=c++11 -Wall -Werror -pedantic -ggdb -pthread

hw2 : hw2.cpp
	g++ $(CPPFLAGS) $< -o $@

try2 : try2.cpp
	g++ $(CPPFLAGS) $< -o $@
check : try2
	valgrind $(VGFLAGS) ./$<
all : hw2 try2
	@echo "Made it all!"
