#include<iostream>

using namespace std;

__global__ void add(int *a, int *b, int *c){
    *c = *a + *b;
}

int main(void){
    // input
    int a, b, c;
    // input to device
    int *d_a, *d_b, *d_c;
    int size = sizeof(int)

    // malloc d_a
    cudaMalloc((void**) &d_a, size);
    cudaMalloc((void**) &d_b, size);
    cudaMalloc((void**) &d_c, size);

    a = 2;
    b = 7;

    cudaMemcpy(d_a, &a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, &b, size, cudaMemcpyHostToDevice);

    add<<<1, 1>>>(d_a, d_b, d_c);
    cout << c << endl;

    cudaMemcpy(&c, d_c, size, cudaMemcpyDeviceToHost);

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    return 0;
}
