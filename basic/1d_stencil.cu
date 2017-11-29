include <iostream>
#define BLOCK_SIZE = 512
#define RADIUS = 3

using namespace std;

__global__ void stencil_1d(int *in, int *out){
    __shared__ int temp[BLOCK_SIZE + 2 * RADIUS];
    int gindex = threadIdx.x + blockIdx.x * blockDim.x;
    int lindex = threadIdx.x + RADIUS;

    temp[lindex] = in[gindex];
    if (threadIdx.x < RADIUS) {
        temp[lindex - RADIUS] = in[gindex - RADIUS];
        temp[lindex + BLOCK_SIZE] = in[gindex + BLOCK_SIZE];
    }

    // To prevent WAW, RAW, WAR hazards, sync threads.
    __syncthreads();

    int result = 0;
    for(int offset=-RADIUS; offset <= RADIUS; offset++){
        result += temp[lindex + offset];
    }

    out[gindex] = result;
}
