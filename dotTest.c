#include <stdio.h>

int main(int argc, char *argv[]){
	extern void dotProduct(unsigned long int arrLen, float *arr0, float *arr2);
	float array0[] = {1.1, 2.2, 3.3, 4.4};
	float array1[] = {2.0, 2.0, 2.0, 2.0};
	dotProduct(128, array0, array1);
}
