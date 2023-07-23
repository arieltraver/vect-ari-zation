#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

extern float dotProduct(float *arr0, float *arr1);

struct args {
    float* arr0;
    float* arr1;
};

void *oneChunk(void *input) {
    printf("product: %f", dotProduct( ((struct args*)input)->arr0, ((struct args*)input)->arr1));
}


int main(int argc, char *argv[]){
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
	/* for (int i= 0; i < 16; i+=8){
		printf("i is %d\n", i); 
		printf("%f\n",dotProduct(array0+i, array1+i));
	}*/

	struct args *Args1 = (struct args *)malloc(sizeof(struct args));
    	Args1->arr0 = array0;
    	Args1->arr1 = array1;

	pthread_t chunk1;
	pthread_create(&chunk1, NULL, oneChunk, (void *)Args1);
	pthread_join(chunk1, NULL);
	free(array0);
	free(array1);
}
