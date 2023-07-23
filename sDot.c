#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]){
	extern float dotProduct(float *arr0, float *arr1);
	//you need these arrays aligned with 32 in order to fit into ymme regs
	float* array0 = (float*) aligned_alloc(32, 16 * sizeof(float));
	printf("%ld\n", sizeof(float));
	float* array1 = (float*) aligned_alloc(32, 16 * sizeof(float));
	for (int i = 0; i < 16; i++){
		array0[i] = 1.1 * i;
		array1[i] = 1.0;
		printf("%f ,", array0[i]);
	}
	printf("\n");
	//for now, just iterate, will run concurrently later
	for (int i= 0; i < 16; i+=8){
		printf("i is %d\n", i); 
		printf("%f\n",dotProduct(array0+i, array1+i));
	}
	
	free(array0);
	free(array1);
}
