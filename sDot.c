#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

extern float dotProduct(float *arr0, float *arr1);

struct args {
    float* arr0;
    float* arr1;
    float* resultIndex;
};

void *oneChunk(void *input) {
    printf("product: %f", dotProduct( ((struct args*)input)->arr0, ((struct args*)input)->arr1));
}

//note: absolute vals (length etc) will or hypothetically will be replaced by variables, we are just using them for testing purposes.
int main(int argc, char *argv[]){
	//you need these arrays aligned with 32 in order to fit into ymme regs
	float* array0 = (float*) aligned_alloc(32, 16 * sizeof(float));
	printf("%ld\n", sizeof(float));
	float* array1 = (float*) aligned_alloc(32, 16 * sizeof(float));
	float* resultsArr = (float*) malloc(2 * sizeof(float));
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
	struct args** argsArr = malloc(2 * sizeof(struct args*));
	for(int i = 0; i < 2; i ++) {
		struct args *Args1 = (struct args *)malloc(sizeof(struct args));
		Args1->arr0 = array0 + i;
		Args1->arr1 = array1 + i;
		Args1->resultIndex = resultsArr + i;
		argsArr[i] = Args1;
	}
	pthread_t* chunks = malloc(2 * sizeof(pthread_t));
	for (int i = 0; i < 2; i++) {
		pthread_create(&chunks[i], NULL, oneChunk, (void*)argsArr[i]);
	}

	for (int i=0; i < 2; i++) {
		printf("loopin\n");
		pthread_join(chunks[i], NULL);
	}
	float sum = 0;
	for (int i=0; i < 2; i++) {
		sum += resultsArr[i];
	}
	printf("%f\n", sum);
	free(chunks);
	free(array0);
	free(array1);
	free(resultsArr);
	free(argsArr);
}
