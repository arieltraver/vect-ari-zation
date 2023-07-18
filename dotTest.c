#include <stdio.h>

int main(int argc, char *argv[]){
	extern void dotProduct(float *arr0, float *arr1, unsigned long int arrlen);
	float array0[] = {1.1, 2.2, 3.3, 4.4};
	float array1[] = {2.0, 2.0, 2.0, 2.0};
	dotProduct(array0, array1, 128);
}
