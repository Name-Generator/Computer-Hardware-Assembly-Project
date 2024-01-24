/*
 * Recursively computes Fibonacci numbers.
 * CSC 225, Assignment 6
 * Given code, Fall '23
 * TODO: Complete this file.
 */
#include "fib.h"
#include <stdio.h>
int main(void) {
	int n, out;
	printf("Enter an integer: ");
	fflush(stdout);
	scanf("%d", &n);
	out = fib(n);
	printf("f(%d) = %d", n, out);
	return 0;
}