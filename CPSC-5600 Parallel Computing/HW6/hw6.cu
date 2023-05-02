/**
 * @file hw6.cu - parallely sort x values and perform parallel scan of y values of a data in csv file.
 * @author Kapish Patel
 * @see "Seattle University, CPSC5600, Winter 2023"
 * @note i have implemented bitonic sort and paralle scan of values in a csv file i have used CUDA to complete this assignment.
    * Step 1: read csv with padding at end if not power of 2 in structure object array
    * Step 2: use bitonic sort to sort x values
    * Step 3: make parallel scan for y values
    * Step 4: Write a csv file from that structure object array
 * OUTPUT:
        1048576 Rows found in: x_y.csv
        Total number of Blocks required: 1024
        Data Sorted Properly.....
        1048576 Rows written in file: Result.csv
        * * *  Memory Free * * *
 * GPU:
        Type       Time(%)   Time        Calls   Avg        Min       Max         Name
 GPU activities:   50.86%  39.902ms       210  190.01us  148.25us  377.04us  bitonic(Data*, int, int)
                   35.21%  27.628ms         1  27.628ms  27.628ms  27.628ms  accum(Data*, float*, int, int)
                    8.36%  6.5619ms         2  3.2810ms  3.2533ms  3.3086ms  [CUDA memcpy DtoH]
                    4.61%  3.6173ms         1  3.6173ms  3.6173ms  3.6173ms  [CUDA memcpy HtoD]
                    0.95%  748.97us         1  748.97us  748.97us  748.97us  scan(Data*, float*, int, int)
      API calls:   55.27%  101.94ms         2  50.971ms  234.71us  101.71ms  cudaMalloc
                   37.32%  68.828ms       212  324.66us  150.88us  27.630ms  cudaDeviceSynchronize
                    6.03%  11.129ms         3  3.7097ms  3.6366ms  3.8291ms  cudaMemcpy
                    0.64%  1.1874ms         2  593.72us  516.46us  670.98us  cudaFree
*/

//Header files 
#include <sys/fcntl.h>  
#include <fcntl.h>
#include <sys/file.h>
#include <iostream>
#include <stdio.h>
#include <sstream>
#include <vector>
#include <fstream>
#include <iomanip>
#include <cfloat>
#include <cmath>

using namespace std;

//Global Variables
const int MAX_BLOCK_SIZE = 1024; // Constant all cuda blocks have 1024 threads
const string filename = "x_y.csv";
const string output_filename = "Result.csv";

//Structure Data to hold data from the csv
struct Data
{
    float x;
    float y;
    int row_num;
    float cumulative_y;
};

// Device swap function which swap values of structure 
__device__ void swap(Data *data, int a, int b) 
{
	Data temp = data[a];
	data[a] = data[b];
	data[b] = temp;
}

//Device Bitonic Function which sort the values in a structure
__global__ void bitonic(Data *values, int j, int k) 
{
    int i = threadIdx.x + blockDim.x * blockIdx.x;
  
    int ixj = i ^ j;

    if ((ixj)>i) 
    {
        if ((i&k)==0) 
        {
            //Sort ascending 
            if (values[i].x>values[ixj].x) 
                swap(values, i, ixj);
        }
        if ((i&k)!=0) 
        {
            //Sort descending 
            if (values[i].x<values[ixj].x)
                swap(values, i, ixj); 
        }
    }
}

//Device scan Function which perform a scan operation on y values
__global__ void scan(Data * data, float * sums, int n, int block_size) 
{
    int block_id = blockIdx.x; //block Id
    int thread_id = threadIdx.x; //thread id
    int idx = block_id * block_size + thread_id; //global index
    if (idx < n) 
        data[idx].cumulative_y = data[idx].y;
    else 
        data[idx].cumulative_y = 0.0;
    __syncthreads();

    //compute prefix sum of the current block 
    for (int stride = 1; stride < blockDim.x; stride <<= 1) 
    {
        __syncthreads();
        int prev_idx = idx - stride;
        if (prev_idx >= block_id * block_size) 
            data[idx].cumulative_y += data[prev_idx].cumulative_y;
    }
    if (thread_id == blockDim.x - 1) 
        sums[block_id] = data[idx].cumulative_y;
    __syncthreads();
}
  
  //accumulate prefix sum parallely
__global__ void accum(Data * data, float * sums, int n, int block_size) 
{
    int block_id = blockIdx.x;
    int thread_id = threadIdx.x;
    int idx = block_id * block_size + thread_id;

    // accumulate the prefix sums of previous blocks
    for (int i = 0; i < block_id; i++) 
    {
        if (block_id > 0) 
            data[idx].cumulative_y += sums[i];
    }
}


//Function declaration
int nearestPowerOfTwo(int n);
void skipLines(fstream& file, int numLines); 
int calcrows(string file);
Data* ReadCSV(int& number_of_rows);
void printdata(Data* data, int& number_of_rows);
void writeCSV(Data* data, int& number_of_rows, string filename);
void validate_Data(Data* data, int& number_of_rows);

// Host function or Main function()
int main()
{
    // code for mutex lock tells if someone is locked out...
    if (flock(open("/home/fac/lundeenk/hw6.lock", O_RDONLY), LOCK_EX|LOCK_NB) == -1) 
    {
        std::cout << "someone has hw6 locked--could it be you?" << std::endl;
        exit(1);
    }

    //Calculate number or rows and nearest power of 2
    int number_of_rows = calcrows(filename);
    int nearest_pow2 = nearestPowerOfTwo(number_of_rows);
    cout<<number_of_rows<<" Rows found in: "<<filename<<endl;
    
    //calculate size of array
    size_t array_Size_bytes = nearest_pow2*sizeof(Data);

    //Allocate memory to host
    Data* data = (Data*)malloc(array_Size_bytes);

    //allocate memory to Device
    Data* d_data;
    cudaMalloc(&d_data , array_Size_bytes);

    //Read the data from CSVfile and store in data
    data = ReadCSV(number_of_rows);

    //Copy the data from host to device memory
    cudaMemcpy(d_data, data, array_Size_bytes, cudaMemcpyHostToDevice);

    //calculating number of threads and blocks required 
    int threads_per_Block = MAX_BLOCK_SIZE;
    int block_in_Grid = (number_of_rows + (MAX_BLOCK_SIZE - 1)) / MAX_BLOCK_SIZE;
    cout<<"Total number of Blocks required: "<<block_in_Grid<<endl;


    //Parallel Bitonic Sort start here...
    //Parallel code CUDA bitonic function call
    for (int k = 2; k <= nearest_pow2; k *= 2) 
    {
        // coming back to the host between values of k acts as a barrier
		// note that in later hardware (compute capabilty >= 7.0), there is a cuda::barrier avaliable
        for (int j = k>>1; j > 0; j = j>>1) 
        {
            bitonic<<<block_in_Grid, threads_per_Block>>>(d_data, j, k);
            cudaDeviceSynchronize();
        }
	}

    //Copy the data from device to host memory
    cudaMemcpy(data, d_data, array_Size_bytes, cudaMemcpyDeviceToHost);

    //Validate Data is it sorted or not
    validate_Data(data, nearest_pow2);


    //Parallel sum or scan start here....
    // a array of flot values which contains parallel sum of a block of data
    float* d_sums;
    cudaMalloc(&d_sums , block_in_Grid);

    //CUDA scan function scans and add data in sums which later on accumulate
    scan<<< block_in_Grid, threads_per_Block >>> (d_data, d_sums, nearest_pow2, block_in_Grid);
    cudaDeviceSynchronize();

    // accumulate prefix sums of each block
    accum<<< block_in_Grid, threads_per_Block >>> (d_data, d_sums, nearest_pow2, block_in_Grid);
    cudaDeviceSynchronize();

    //Copy the data from device to host memory
    cudaMemcpy(data, d_data, array_Size_bytes, cudaMemcpyDeviceToHost);


    //Write data in Result.csv file
    writeCSV(data, number_of_rows, output_filename);
    cout<<number_of_rows<<" Rows written in file: "<<output_filename<<endl;

    //Free used memory
    cout<<"* * *  Memory Free * * *"<<endl;
    cudaFree(d_data);
    cudaFree(d_sums);
    delete []data;
    return 0;
}

/*=========================================================FUNCTION DEFINATION===================================================================*/
//function to find next nearest power of 2
int nearestPowerOfTwo(int n) 
{
    // If n is already a power of 2, return n
    if (ceil(log2(n)) == floor(log2(n))) 
        return n;

    // Find the next power of 2 and the previous power of 2
    int nextPowerOfTwo = pow(2, ceil(log2(n)));

    // Return the nearest power of 2 
    return nextPowerOfTwo;
}

//function to skip entered number of lines
void skipLines(fstream& file, int numLines) 
{
    string line;
    for (int i = 0; i < numLines; i++) 
    {
        if (!std::getline(file, line)) 
            break;  // we've reached the end of the file before skipping all the lines
    }
}

//function to calculate number of rows
int calcrows(string filename)
{
    fstream fin;

    string line;

    fin.open(filename, ios::in);
    if (fin.fail())
    {
        cerr<<"Unable to open file"<<filename<<endl;
        exit(1);
    }

    //for loop to skip given number of lines
    int number_of_line_skip = 1;
    skipLines(fin, number_of_line_skip);

    int number_of_rows = 0;
    while (getline(fin, line)) 
    {
        number_of_rows++;
    }

    //Close file
    fin.close();
    return number_of_rows;
}

//Function to set data into structure
Data* ReadCSV(int& number_of_rows)
{
    // File pointer
    fstream fin;

    //variable for getting a line from file
    string line;
   
    // Open the file
    fin.open(filename, ios::in);
    if (fin.fail())
    {
        cerr<<"Unable to open file"<<filename<<endl;
        exit(1);
    }

    //convert number of rows to nearest power of 2 
    int nearest_pow2 = nearestPowerOfTwo(number_of_rows);

    //Object of Structure
    Data* data = new Data[nearest_pow2];

    int number_of_line_skip = 1;
    skipLines(fin, number_of_line_skip);

    for (int i = 0; i < number_of_rows; i++)
    {
        getline(fin, line);
        sscanf(line.c_str(), "%f,%f", &data[i].x, &data[i].y);
        data[i].row_num = i+1; 
        data[i].cumulative_y = 0.0;
    }
    
    for (int i = number_of_rows; i < nearest_pow2; i++)
    {
        data[i].x = FLT_MAX;
        data[i].y = 0;
        data[i].cumulative_y = 0.0;
        data[i].row_num = i+1;
    }
    fin.close();
    return data;
}

//Function to write all the data into csv file
void writeCSV(Data* data, int& number_of_rows, string filename) 
{
    ofstream outfile;
    outfile.open(filename);

    outfile << "Row Number,Value of X,Value of Y, Cumilative Y\n";

    for (int i = 0; i < number_of_rows; i++) 
    {
        outfile << data[i].row_num << ","
                << data[i].x << ","
                << data[i].y << ","
                << data[i].cumulative_y << "\n";
    }

    outfile.close();
}

//Function to validate the sorting of x elements
void validate_Data(Data* data, int& number_of_rows)
{
    for (int i = 0; i < number_of_rows - 1; i++)
    {
        if (data[i].x > data[i+1].x)
        {
            cout<<"Data Not Sorted Properly. Element: "<<i<<endl<<data[i].x<<" > "<<data[i+1].x<<endl;
            return ;
        }
    }
    cout<<"Data Sorted Properly....."<<endl;
}