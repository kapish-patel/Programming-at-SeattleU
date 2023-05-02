/**
 * @file hw2.cpp - implement  Ladner-Fischer† parallel prefix sum algorithm
 * @author Kapish Patel
 * 
 * NOTE - I have not attempted the extra credit part
 *      - My hw2.cpp takes too much time to compile so please be patient for at least 2min
 */

// includes Header files
#include<iostream>
#include<chrono>
#include<vector>
#include<future>
#include<pthread.h>
#include <cmath>

using namespace std;

// Typedef
typedef vector<int> Data; // name replica alias for vector

// constants
const int N = 1<<26; // 1<<26 by default testcasse
const int test_start = 10;

/**
 * @class Heaper - Implement the heap which stores the interior nodes of tree
 * 
 * @param data which is vector  
 * 
 * Heaper(base) classs
*/
class Heaper
{
    // Public Section:
    public:

     // constructor
    Heaper(const Data *data) : n(data->size()), data(data)
    {
        interior = new Data(n-1, 0);
    }

    // Destructor
    virtual ~Heaper()
    {
        delete interior;
    }

    // Protected Section:
    protected:
    
    // Data Member
    int n;              // n for storing size of vector and n-1 is size of interior nodes
    const Data *data;   // data array originally vector
    Data *interior;     // interior node array originally vector
    
    // Member Functions
    
    /**
     * level function to determine which level are we in a tree
     * 
     * @param id - id of node
    */
    virtual int level(int id)
    {
        int n=1;
        int count=1;
        while (n < id)
        {
            n = pow(2, count);
            count++;
        }
        return count;
    }

    /**
     * size function to retrive size of tree
    */
    virtual int size()
    {
        return (n-1)+n;
    }

    /**
     * value function to retrive value of a node
     * 
     * @param i - id of node
    */
    virtual int value(int i)
    {
        if(i < n-1)
            return interior->at(i);
        else
            return data->at(i-(n-1));
    }

    /**
     * hasleft function to check if a node has left value or not
     * 
     * @param parentIndex - id of parent node
    */
    bool hasleft(int parentIndex)
    {
        return left(parentIndex) < n;
    }

    /**
     * hasright function to check if a node has right value or not
     * 
     * @param parentIndex - id of parent node
    */
    bool hasright(int parentIndex)
    {
        return right(parentIndex) < n;
    }

    /**
     * isLeaf function to retrive a node is leaf or not
     * 
     * @param i - id of node
    */
    virtual bool isLeaf(int i)
    {
       if(i >= n-1)
        {   
            return true;
        }
        else{
            return false;
        }
    }

    /**
     * right function to retrive right node
     * 
     * @param parentIndex - id of parent node
    */
    virtual int right(int parentIndex) 
    {
        return left(parentIndex) + 1;
    }

    /**
     * left function to retrive left node 
     * 
     * @param parentIndex - id of parent node
    */
    virtual int left(int parentIndex) 
    {
        return parentIndex * 2 + 1;
    }

    /**
     * hasLeft function to check if a node has left child
     * 
     * @param parentIndex - id of parent node
    */
    virtual bool hasLeft(int parentIndex) 
    {
        return left(parentIndex) < n;
    }

    /**
     * hasRight function to check if a node has right child
     * 
     * @param parentIndex - id of parent node
    */
    virtual bool hasRight(int parentIndex)
    {
        return right(parentIndex) < n;
    }
};



/**
 * @class SumHeap - Implement prefix sum of data
 * 
 * @param data which is vector  
 * 
 * SumHeap class (deriver from Heaper) 
*/
class SumHeap : public Heaper
{
    //Public Section:
    public:
   
    // Data Members
    int count = 0;
    int max_level = 4;

    //constructor
        SumHeap(const Data *data) : Heaper(data)
        {
            calcsum(0);
        }

    // Member Functions

    /**
     * prefixSums function to perform prifix sum in parallel form
     * 
     * @param id - id of node
     * @param previous_sum - cumulative sum of data
     * @param prefix - Vector which will store the prefix sum
    */
    void prefixSums(int id, int previous_sum, Data *prefix)
    {
        // Check is current Id is Leaf node or not
        if (isLeaf(id))
        {
            if (previous_sum >= test_start)
            {
                prefix->at(count) = previous_sum;
                count++;

                if (count == n-1)
                    prefix->pop_back();
            }
        }
        else
        {
            if (level(id) < max_level)
            {
                // Std async function to fork thread for left side.
                auto handle_left = std::async(std::launch::async, &SumHeap::prefixSums, this, left(id), previous_sum, prefix);
                handle_left.wait();

                // Std async function to fork thread for right side.
                auto handle_right = std::async(std::launch::async, &SumHeap::prefixSums, this, right(id), previous_sum + value(left(id)), prefix);
                handle_right.wait();
            }
            else
            {
                // recursion for left side and right side
                prefixSums(left(id), previous_sum, prefix);
                prefixSums(right(id), previous_sum + value(left(id)), prefix);
            }
        }
    }

    // Private Section:
    private:
    
    /**
     * calcsum function to perform sum calculation and node creation
     * 
     * @param i - id of node
    */
        void calcsum(int i)
        {
            // Check is current Id is Leaf node or not
            if(isLeaf(i))
            {
                return;
            }
            if (level(i) < max_level)
            {
                // Std async function to fork thread for left side.
                auto handle = std::async(std::launch::async, &SumHeap::calcsum, this, left(i));
                
                // recursion for right side
                calcsum(right(i));
                
                // wait for left thread to complete operations
                handle.wait();
            }
            else
            {
                // recursion for left side and right side
                calcsum(left(i));
                calcsum(right(i));
            }

            // calculate Sum for left and right and store it in interior node
            interior->at(i) = value(left(i)) + value(right(i));
        }
};

/**
 * Main function - performs creation of object tand validation of prefixsum
*/
int main() {
    Data data(N, 1);  // put a 1 in each element of the data array
    data[0] = 10;
    Data prefix(N, 1);

    // start timer
    auto start = chrono::steady_clock::now();

    // Object of SumHeap class 
    SumHeap heap(&data);
    heap.prefixSums(0, 0, &prefix);
    
    // stop timer
    auto end = chrono::steady_clock::now();
    auto elpased = chrono::duration<double,milli>(end-start).count();

    // Validation of prefix sum
    int check = 10;
    for (int elem: prefix)
    {
        if (elem != check++) 
        {
            cout << "FAILED RESULT at " << check-1;
            break;
        }
    }
    cout << " in " << elpased << "ms" << endl;
    return 0;
}

/**
 * Expected output as per Professor instruction:
 * in 1100.00ms
 * 
 * Output from my hw2.cpp:
 * in 124002ms
 * 
 * my output time is too much which dont know why? but i have used parallel and recursive method as mentioned in instruction
*/