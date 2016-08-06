//--------------------------------------------------
//Student Name: Suhanya Jayatillake
//Student Number: 1432284
//Subject: High Performance Computing
//Project Description:
// This program creates two matrices with random numbers and
// and those two matrices. Size of the matrices can be changed
//  by changing the value of N.
//  In this program, number of blocks used for processing is one.
//--------------------------------------------------
#include <stdio.h>
#include <stdlib.h>

#define N 22

// Kernel definition 

__global__ void MatAdd(int A[][N], int B[][N], int C[][N]){
           int i = threadIdx.x;
           int j = threadIdx.y;

           C[i][j] = A[i][j] + B[i][j];
}

//int** randmatfunc();


void randmatfunc(int newmat[N][N]){
  int i, j, k; 
    for(i=0;i<N;i++){
        for(j=0;j<N;j++){
          k = rand() % 100 + 1;;
            printf("%d ", k);
            newmat[i][j] =k;
        }
        printf("\n");
       
    } 
  printf("\n*************************************\n"); 
}

int main(){

int A[N][N];  
randmatfunc(A);
  
int B[N][N];  
randmatfunc(B);  



  int C[N][N];
  
  //calling the poniters 

  int (*d_A)[N], (*d_B)[N], (*d_C)[N];
  
  // allocate and initialize on the GPU

  cudaMalloc((void**)&d_A, (N*N)*sizeof(int));
  cudaMalloc((void**)&d_B, (N*N)*sizeof(int));
  cudaMalloc((void**)&d_C, (N*N)*sizeof(int));

  //Copy result from device memory to host memory

  cudaMemcpy(d_A, A, (N*N)*sizeof(int), cudaMemcpyHostToDevice);
  cudaMemcpy(d_B, B, (N*N)*sizeof(int), cudaMemcpyHostToDevice);
  cudaMemcpy(d_C, C, (N*N)*sizeof(int), cudaMemcpyHostToDevice);

  int numBlocks = 1;
  
  // Kernel invocation with N threads 

  dim3 threadsPerBlock(N,N);

  MatAdd<<<numBlocks,threadsPerBlock>>>(d_A,d_B,d_C);
  
  //perform copies

  cudaMemcpy(C, d_C, (N*N)*sizeof(int), cudaMemcpyDeviceToHost);

  //fill the metrics on cpu

  int i, j; printf("C = \n");
    for(i=0;i<N;i++){
        for(j=0;j<N;j++){
            printf("%d ", C[i][j]);
        }
        printf("\n");
    }

  //clean up

  cudaFree(d_A); 
  cudaFree(d_B); 
  cudaFree(d_C);

  printf("\n");

  return 0;
}

