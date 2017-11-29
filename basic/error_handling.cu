#include <iostream>

using namespace std;

int main(void){
    cudaError_t cudaGetLastError(void);

    cout << cudaGetErrorString(cudaGetLastError()); << endl;
}
