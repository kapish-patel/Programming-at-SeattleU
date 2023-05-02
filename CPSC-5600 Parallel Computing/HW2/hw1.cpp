#include<iostream>
#include<vector>
#include<future>
#include<chrono>
#include<pthread.h>

using namespace std;

typedef vector<int> Data;

const int N = 4; // FIXME must be power of 2 for now


class Heaper 
{
    protected:
        int n; // n is size of date, n-1 is size of interior
        const Data *data;
        Data *interior;

        virtual int size()
        {
            return (n-1) + n;
        }

        virtual int value(int i)
        {
            if (i < n-1)
                return interior->at(i);
            else
                return data->at(i - (n-1));
        }
    public:
        Heaper(const Data *data) : n(data->size()), data(data)
        {
            interior = new Data(n-1, 0);
        }        
        
        virtual ~Heaper()
        {
            delete interior;
        }
};


class SumHeap : public Heaper
{
    private:
        void calcSum(int i)
        {
            if (isLeaf(i)) // work with has left and has right  in heap.cpp
            {
                cout<<"Leaf Node:" << i <<endl;
                return;
            }
            auto handle = std::async(std::launch::async, &SumHeap::calcSum, this, left(i));
            //calcSum(left(i));
            calcSum(right(i));
            handle.wait();
            interior->at(i) = value(left(i)) + value(right(i));
            cout<<"interior node "<< i <<" Value (L+R) : "<< interior->at(i)<<" "<< value(left(i)) << "+"<< value(right(i))<< endl;
        }
    public:
        SumHeap(const Data *data) : Heaper(data)
        {
            for (int i = 0; i < N; i++)
            {
                cout<<"Data Elements:"<< data->at(i)<< endl;
            }
            calcSum(0);
        }

        bool isLeaf(int i)
        {
            if (!hasleft(i) && !hasright(i))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        int sum(int node = 0)
        {
            return value(node);
        }

        int left(int parentIndex)
        {
            return parentIndex * 2 + 1;
        }

        int right(int parentIndex)
        {
            return left(parentIndex) + 1;
        }
        
        int parent(int childindex)
        {
            return (childindex - 1) / 2;
        }

        bool hasleft(int parentIndex)
        {
            return left(parentIndex) < n;
        }

        bool hasright(int parentIndex)
        {
            return right(parentIndex) < n;
        }
       // make prefixSums function here
};


int main() {
    Data data(N, 1);  // put a 1 in each element of the data array
    data[0] = 10;
    Data prefix(N, 1);

    // start timer
    auto start = chrono::steady_clock::now();

    SumHeap heap(&data);
    // heap.prefixSums(&prefix);

    // stop timer
    auto end = chrono::steady_clock::now();
    auto elpased = chrono::duration<double,milli>(end-start).count();

    int check = 10;
    for (int elem: prefix)
        if (elem != check++) {
            cout << "FAILED RESULT at " << check-1;
            break;
        }
    cout << "in " << elpased << "ms" << endl;
    return 0;
}