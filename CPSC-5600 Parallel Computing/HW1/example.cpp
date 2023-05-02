/**
 * @file example.cpp - demonstrate use of ThreadGroup class for HW1
 * @author Kevin Lundeen
 * @see "Seattle University, CPSC5600, Fall 2018"
 */
#include <iostream>
#include <string>
#include "ThreadGroup.h"

/**
 * @class Example - the template argument to ThreadGroup just has
 * to have an implementation of the ()-operator. (If you're 
 * familiar with the STL, this is how functionality is passed in
 * to hash tables, etc.).
 */
class Example {
public:
	void operator()(int id, void *sharedData) {
		std::cout << "Hello from thread " << id << std::endl;
		std::string *ourData = (std::string*)sharedData;
		ourData[id] = "done " + std::to_string(id);
	}
};

const int N_THREADS = 4;

int main() {
	// Make some shared data structure (here an array of strings).
	// In this demo, we have each thread write a message in the part 
	// of the array it "owns".
	std::string ourData[N_THREADS];
	for (int i = 0; i < N_THREADS; i++)
		ourData[i] = "";

	// Create a thread group using our HW1-provided ThreadGroup class..
	//
	// Any thread created in the group with createThread will run 
	// Example's ()-operator.
	//
	// Then waitForAll will act as a barrier and wait for all the 
	// threads in the group to finish.
	std::cout << "Starting " << N_THREADS << " threads." << std::endl;
	ThreadGroup<Example> example;
	for (int i = 0; i < N_THREADS; i++)
		example.createThread(i, ourData);
	example.waitForAll();

	// Report the results once all the threads join (i.e., are finished)
	std::cout << "All threads are now done!" << std::endl;
	for (int i = 0; i < N_THREADS; i++)
		std::cout << "thread " << i << " wrote: " << ourData[i] << std::endl;

	return 0;
}
