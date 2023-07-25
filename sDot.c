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
	float* resultsArr = (float*) malloc(2 * sizeOf(float))
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
	void* argsArr = malloc(2 * sizeof(void*))
	for(int i = 0; i < 2; i ++) {
		struct args *Args1 = (struct args *)malloc(sizeof(struct args));
		Args1->arr0 = array0 + i;
		Args1->arr1 = array1 + i;
		Args1->resultsIndex = resultsArr + i;
		argsArr[i] = (void *)Args1;
	}
	pthread_t* chunks = malloc(2 * sizeof(pthread_t))
	for (int i = 0; i < 2; i++) {
		pthread_t chunk1;
		chunks[i] = chunk1;
	}
	for (int i = 0; i < 2; i++) {
		pthread_create(&chunks[i], NULL, oneChunk, argsArr[i])
	}

	for (int i=0; i < 2; i++) {
		pthread_join(chunks[i], NULL);
	}
	float sum = 0;
	for (int i=0; i < 2; i++) {
		sum += resultsArr[i]
	}
	printf("%f\n", sum);
	/*
	pthread_t chunk1;
	pthread_create(&chunk1, NULL, oneChunk, (void *)Args1);
	pthread_join(chunk1, NULL);*/
	free(chunks);
	free(argsArr);
	free(array0);
	free(array1);
	free(resultsArr);
}
