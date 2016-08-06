//--------------------------------------------------------------
//Student Name:Suhanya Jayatillake
//Student Number: 1432284
//Subject: High Performance Computing
//Project Description:
//Task 1-Converting the C program to CUDA
//--------------------------------------------------------------

#include <stdio.h>
#include <stdlib.h>

#define N 4


// Kernel definition 

__global__ void MatAdd(int A[][N], int B[][N], int C[][N]){
           int i = threadIdx.x;
           int j = threadIdx.y;

           C[i][j] = A[i][j] + B[i][j];
}


int main(){

  int A[N][N] =
    {
      {1, 5, 6, 7},
      {4, 4, 8, 0},
      {2, 3, 4, 5},
      {2, 3, 4, 5}
   };

  int B[N][N] = 
    {
      {1, 5, 6, 7},
      {4, 4, 8, 0},
      {2, 3, 4, 5},
      {2, 3, 4, 5}
   };

  int C[N][N] = 
     {
      {0, 0, 0, 0},
      {0, 0, 0, 0},
      {0, 0, 0, 0},
      {0, 0, 0, 0}
   };

  //calling the poniters 

  int (*d_A)[N], (*d_B)[N], (*d_C)[N];

  // allocate the memory on the GPU

  cudaMalloc((void**)&d_A, (N*N)*sizeof(int));
  cudaMalloc((void**)&d_B, (N*N)*sizeof(int));
  cudaMalloc((void**)&d_C, (N*N)*sizeof(int));

  //Copy result from device memory to host memory

  cudaMemcpy(d_A, A, (N*N)*sizeof(int), cudaMemcpyHostToDevice);
  cudaMemcpy(d_B, B, (N*N)*sizeof(int), cudaMemcpyHostToDevice);
  cudaMemcpy(d_C, C, (N*N)*sizeof(int), cudaMemcpyHostToDevice);

  int numBlocks = 1;
  dim3 threadsPerBlock(N,N);
  MatAdd<<<numBlocks,threadsPerBlock>>>(d_A,d_B,d_C);
  
  //Copy Result back to host

  cudaMemcpy(C, d_C, (N*N)*sizeof(int), cudaMemcpyDeviceToHost);

  int i, j; printf("C = \n");
  
  // fill the matrices on the CPU

    for(i=0;i<N;i++){
        for(j=0;j<N;j++){
            printf("%d ", C[i][j]);
        }
        printf("\n");
    }
  
  //free device memory

  cudaFree(d_A); 
  cudaFree(d_B); 
  cudaFree(d_C);

  printf("\n");

  return 0;
}

