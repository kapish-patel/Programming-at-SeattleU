/**
 * @file hw1.cpp is converts the simple sequential encoding and Decoding in to paralle form 
 * @author Kapish Patel
 */
#include <iostream>
#include <array>
#include "ThreadGroup.h"
using namespace std;

/**
 * Constant TOTAL_THREADS this represent total number of threads that we are going to use.
*/
const int TOTAL_THREADS = 2;

/*
	SharedData - Structure holds data which need to be shared between threads

	DataMembers:
		*data - int data stores address of array.
		size - int size stores size of array.
		encode_sum - int encode_sum stores sum of encoded array.   
*/
struct SharedData
{
	int *data;
	int size;
	int encode_Sum;
};

/**
* 	encode which does nothing just consuming time.

*	@param - accepts and int value.
*/
int encode(int v) 
{
	// do something time-consuming (and arbitrary)
	for (int i = 0; i < 500; i++)
		v = ((v * v) + v) % 10;
	return v;
}

/**
* 	Decode which does nothing just consuming time.

*	@param - accepts and int value.
*/
int decode(int v) 
{
	// do something time-consuming (and arbitrary)
	return encode(v);
}

/**
 * @class EncodeThread - use to process the encoding operation on each thread
*/
class EncodeThread
{
	public:
	/**
	 * Operator function seprates data and encodes the data.   
	 * @param int which is id of thread so that we can determine which part of data will a particular thread is responsible.
	 * @param void which is a pointer of structure SharedDate which contains all the data.  
	*/
	int operator()(int id, void *sharedData)
	{
		SharedData *ourdata = (SharedData*)sharedData;
		int length_per_Thread = ourdata->size/TOTAL_THREADS;
		int start = id * length_per_Thread;
		for (int i = start; i < start+length_per_Thread; i++) 
		{
			ourdata->data[i] = encode(ourdata->data[i]);
		}
		return 0;
	}
};
/**
 * @class DecodeThread - use to process the decoding operation on each thread
*/
class DecodeThread
{
	public:
	/**
	 * Operator function seprates data and decodes the data.   
	 * @param int which is id of thread so that we can determine which part of data will a particular thread is responsible.
	 * @param void which is a pointer of structure SharedDate which contains all the data.  
	*/
	int operator()(int id, void *sharedData)
	{
		SharedData *ourdata = (SharedData*)sharedData;
		int length_per_Thread = ourdata->size/TOTAL_THREADS;
		int start = id * length_per_Thread;
		for (int i = start; i < start+length_per_Thread; i++) 
		{
			ourdata->data[i] = decode(ourdata->data[i]);
		}
		return 0;
	}
};

/**
 * Prefixsum function is used for creation of threads and performing encode and decode operations.
 * 
 * @param int pointer of data which is a array. 
 * @param int length of array passes before. 
*/
void prefixSums(int *data, int length) 
{
	// Object of Structure SharedData creation and assigning values to data member
	SharedData ourData;
	ourData.data = data;
	ourData.size = length;
	
	// Threads for encoding 
	cout << "Starting " << TOTAL_THREADS << " threads for Encoding." << endl;
	ThreadGroup<EncodeThread> encoders;
	for (int i = 0; i < TOTAL_THREADS; i++)
	    encoders.createThread(i, &ourData);
    encoders.waitForAll();
	cout << "Stopping " << TOTAL_THREADS << " threads of Encoding." << endl;

	//sequential sum of encoded array
	ourData.encode_Sum = 0;
	for (int i = 0; i < ourData.size; i++)
	{
		ourData.encode_Sum += ourData.data[i];
	}

	// Threads for Decoding
	cout << "Starting " << TOTAL_THREADS << " threads for Decoding." << endl;
	ThreadGroup<DecodeThread> decoders;
	for (int i = 0; i < TOTAL_THREADS; i++)
	    decoders.createThread(i, &ourData);
    decoders.waitForAll();
	cout << "Stopping " << TOTAL_THREADS << " threads of Decoding." << endl;

}

int main() 
{
	int length = 1000 * 1000;

	// make array
	int *data = new int[length];
	for (int i = 1; i < length; i++)
	{
		data[i] = 1;
	}
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


/**
 * Time in Sequencial Version:
 * real    0m7.386s
 * user    0m7.363s
 * sys     0m0.003s
 * 
 * Time in Parallel Version(Multi Threaded Version)
 * real    0m3.632s
 * user    0m7.172s
 * sys     0m0.007s
*/