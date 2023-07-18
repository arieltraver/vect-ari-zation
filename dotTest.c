#include <stdio.h>

int main(int argc, char *argv[]){
	extern void dotProduct(float *arr0, float *arr1, unsigned long int arrlen);
	float array0[] = {1.1, 2.2, 3.3, 4.4};
	float array1[] = {2.0, 2.0, 2.0, 2.0};
	dotProduct(array0, array1, 128);
	printf("%f, %f, %f, %f\n", array0[0], array0[1], array0[2], array0[3]);
	printf("%f, %f, %f, %f\n", array1[0], array1[1], array1[2], array1[3]);
}
