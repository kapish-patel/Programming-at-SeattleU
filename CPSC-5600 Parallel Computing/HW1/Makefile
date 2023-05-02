CPPFLAGS = -std=c++11 -Wall -Werror -pedantic -ggdb -pthread

hw1 : hw1.cpp
	g++ $(CPPFLAGS) $< -o $@

hw1_setup : hw1_setup.cpp
	g++ $(CPPFLAGS) $< -o $@

Thread :  ThreadGroup.h
	g++ $(CPPFLAGS) $< -o $@

all : Thread hw1
	@echo "Made it all!"
