#include<iostream>

# define N 512

using namespace std;

__global__ void add(int *a, int *b, int *c){
    c[threadIdx.x] = a[threadIdx.x] + b[threadIdx.x];
}

int main(void){
    // input
    int *a, *b, *c;
    // input to device
    int *d_a, *d_b, *d_c;
    int size = N * sizeof(int)

    // malloc d_a
    cudaMalloc((void**) &d_a, size);
    cudaMalloc((void**) &d_b, size);
    cudaMalloc((void**) &d_c, size);
    
    a = (int *) malloc(size); random_ints(a, N);
    b = (int *) malloc(size); random_ints(b, N);
    c = (int *) malloc(size);


    // Use N threads
    cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);

    add<<<1, N>>>(d_a, d_b, d_c);

    cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost);

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);
    free(a); free(b); free(c);

    return 0;
}
