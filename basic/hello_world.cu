#include<iostream>

using namespace std;

__global__ void mykernel(void){
}

int main(void){
    mykernel<<<1, 1>>>();
    cout << "Hello World!\n" << endl;
    return 0;
}
