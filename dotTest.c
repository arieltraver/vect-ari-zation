#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]){
	extern float dotProduct(float *arr0, float *arr1, unsigned long int arrlen);
	//you need these arrays aligned with 32 in order to fit into ymme regs
	float* array0 = (float*) aligned_alloc(32, 8 * sizeof(float));
	printf("%ld\n", sizeof(float));
	float* array1 = (float*) aligned_alloc(32, 8 * sizeof(float));
	for (int i = 0; i < 8; i++){
		array0[i] = 1.1 * i + 1;
		array1[i] = 1.0;
		printf("%f ,", array0[i]);
	}
	printf("\n");
	printf("%f\n",dotProduct(array0, array1, 8));
	
	float* array2 = (float*) aligned_alloc(32, 8 * sizeof(float));
	float* array3 = (float*) aligned_alloc(32, 8 * sizeof(float));
	for (int i = 0; i < 8; i++){
		array2[i] = 1.1 * i;
		array3[i] = 1.0;
		printf("%f , ", array2[i]);
	}
	printf("\n");
	printf("%f\n",dotProduct(array2, array3, 8));

	free(array0);
	free(array1);
	free(array2);
	free(array3);
}
