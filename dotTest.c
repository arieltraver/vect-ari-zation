#include <stdio.h>

int main(int argc, char *argv[]){
	extern void dotProduct(float *arr0, float *arr2, int arrLen);
	float array0[] = {1.1, 2.2, 3.3, 4.4}
	float array1[] = {2.0, 2.0, 2.0, 2.0}
	dotProduct(128, array0, array1)
}
