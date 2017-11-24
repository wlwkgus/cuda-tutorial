#include<iostream>

#define N 512
using namespace std;

__global__ void add(int *a, int *b, int *c){
    c[blockIdx.x] = a[blockIdx.x] + b[blockIdx.x];
}

void random_ints(int* a, int N){
    int i;
    for(i=0; i < N; i++){
        a[i] = rand();
    }
}

int main(void){
    // input
    int *a, *b, *c;
    // input to device
    int *d_a, *d_b, *d_c;
    int size = sizeof(int);

    // malloc d_a
    cudaMalloc((void**) &d_a, size);
    cudaMalloc((void**) &d_b, size);
    cudaMalloc((void**) &d_c, size);

    a = (int *) malloc(size); random_ints(a, N);
    b = (int *) malloc(size); random_ints(b, N);
    c = (int *) malloc(size);

    cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);

    // use N blocks.
    add<<<N, 1>>>(d_a, d_b, d_c);

    cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost);

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);
    free(a);
    free(b);
    free(c);

    return 0;
}
