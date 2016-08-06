//Student Name: Suhanya Jayatillake
//Subject: High Performance Computing
//metrics-1432284.c
//Task1- C code

#include <stdio.h>

#define N 4
 
int main()
{
   int i, j =0;

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

 
     for(i=0;i<N;i++){
        for(j=0;j<N;j++){
            C[i][j] = A[i][j] + B[i][j];
        }
    }
 
   printf("Sum of entered matrices:-\n");
 
    for(i=0;i<N;i++){
        for(j=0;j<N;j++){
            printf("%d ", C[i][j]);
        }
        printf("\n");
    }
 
   return 0;
}
