/**
 * Based on idea from Matthew Flatt, Univ of Utah
 */
#include <iostream>
#include "ThreadGroup.h"
using namespace std;


int encode(int v) {
	// do something time-consuming (and arbitrary)
	for (int i = 0; i < 500; i++)
		v = ((v * v) + v) % 10;
	return v;
}

int decode(int v) {
	// do something time-consuming (and arbitrary)
	return encode(v);
}

void prefixSums(int *data, int length) {
	// FIXME: change this to be done in parallel in hw
	int encodedSum = 0;
	for (int i = 0; i < length; i++) {
		encodedSum += encode(data[i]);
		data[i] = decode(encodedSum);
	}
}

int main() {
	int length = 1000 * 1000;

	// make array
	int *data = new int[length];
	for (int i = 1; i < length; i++)
		data[i] = 1;
	data[0] = 6;

	// transform array into converted/deconverted prefix sum of original
	prefixSums(data, length);

	// printed out result is 6, 6, and 2 when data[0] is 6 to start and the rest 1
	cout << "[0]: " << data[0] << endl
			<< "[" << length/2 << "]: " << data[length/2] << endl 
			<< "[end]: " << data[length-1] << endl; 

    delete[] data;
	return 0;
}
