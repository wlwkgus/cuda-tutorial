#include<iostream>

using namespace std;

__global__ void mykernel(void){
}

int main(void){
    mykernel<<<1, 1>>>();
    printf("Hello World!\n");
    return 0;
}
