#include <iostream>
#include <string.h>
#include <array>
#include <vector>
using namespace std;

typedef vector<int> Data;

struct Sharedata
{
    Data *data;
};


void display(void* sharedData)
{
    Sharedata *ourdata = (Sharedata*)sharedData;
    cout<< ourdata->data;
}


int main()
{
    Data array;
    Sharedata ourData;
    ourData.data = array;
    display(ourData);
    
    
    /*int count = 0;
    for (auto i: array)
    {
        count++;
    }
    cout<<count;*/
    /*int size = sizeof(array)/sizeof(array[0]);
    int farray[size/2], sarray[size/2];
    for (int i = 0; i < size/2; i++)
    {
        farray[i] = array[i];
    }
    cout<<farray[4]<<endl;
    for (int i = (size/2); i < size; i++)
    {
        sarray[i - (size/2)] = array[i];
    }
    cout<<sarray[0]<<endl;
    cout<<sarray[1]<<endl;
    cout<<sarray[2]<<endl;
    cout<<sarray[3]<<endl;
    cout<<sarray[4]<<endl;
    */
    
    
    /*int farray[size/2], sarray[size/2];  
    cout << "Size of array is: " << size<< endl;
    for (int i=0; i<(size/2); i++)
    {
        farray[i] = array[i];
    }
    for (int i = size; i > size/2; i--)
    {
        sarray[i] = array[i];
    }
    for (int i = 0; i < size/2; i++)
    {
        cout<<"1 array:"<<farray[i]<<endl;
        cout<<"2 array:"<<sarray[i]<<endl;
    }*/
    
    return 0;
}