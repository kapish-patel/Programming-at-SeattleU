/**
 * reduce_scan_1block.cu - using dissemination reduction for reducing and scanning a small array with CUDA
 * Kevin Lundeen, Seattle University, CPSC 5600 demo program
 * Notes:
 * - only works for one block (maximum block size for all of CUDA is 1024 threads per block)
 * - eliminated the remaining data races that were in reduce_scan_naive.cu
 * - algo requires power of 2 so we pad with zeros up to 1024 elements
 * - now a bit faster using block shared memory during loops (which also handily exposed the data races we had before)
 */

#include <iostream>
using namespace std;

const int MAX_BLOCK_SIZE = 1024;

__global__ void allreduce(float *data) {
    __shared__ float local[MAX_BLOCK_SIZE]; // 10x faster at least than global memory via data[]
    int gindex = threadIdx.x;
    int index = gindex;
    local[index] = data[gindex];
    for (int stride = 1; stride < blockDim.x; stride *= 2) {

        __syncthreads();  // wait for my writing partner to put his value in local before reading it
        int source = (index - stride) % blockDim.x;
        float addend = local[source];

        __syncthreads();  // wait for my reading partner to pull her value from local before updating it
        local[index] += addend;
    }
    data[gindex] = local[index];
}

__global__ void scan(float *data) {
    __shared__ float local[MAX_BLOCK_SIZE];
    int gindex = threadIdx.x;
    int index = gindex;
    local[index] = data[gindex];
    for (int stride = 1; stride < blockDim.x; stride *= 2) {

        __syncthreads();  // cannot be inside the if-block 'cuz everyone has to call it!
        int addend = 0;
        if (stride <= index)
            addend = local[index - stride];

        __syncthreads();
        local[index] += addend;
    }
    data[gindex] = local[index];
}

void fillArray(float *data, int n, int sz) {
    for (int i = 0; i < n; i++)
        data[i] = (float)(i+1); // + (i+1)/1000.0;
    for (int i = n; i < sz; i++)
        data[i] = 0.0; // pad with 0.0's for addition
}

void printArray(float *data, int n, string title, int m=5) {
    cout << title << ":";
    for (int i = 0; i < m; i++)
        cout << " " << data[i];
    cout << " ...";
    for (int i = n - m; i < n; i++)
        cout << " " << data[i];
    cout << endl;
}

int main(void) {
    int n;
    float *data;
    int threads = MAX_BLOCK_SIZE;
    cout << "How many data elements? ";
    cin >> n;
    if (n > threads) {
        cerr << "Cannot do more than " << threads << " numbers with this simple algorithm!" << endl;
        return 1;
    }
    cudaMallocManaged(&data, threads * sizeof(*data));
    fillArray(data, n, threads);
    printArray(data, n, "Before");
    allreduce<<<1, threads>>>(data);
    cudaDeviceSynchronize();
    printArray(data, n, "Reduce");
    fillArray(data, n, threads);
    scan<<<1, threads>>>(data);
    cudaDeviceSynchronize();
    printArray(data, n, "Scan");
    return 0;
}
