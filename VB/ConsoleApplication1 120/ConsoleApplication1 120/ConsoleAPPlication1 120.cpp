#include<stdio.h>
#define DEBUG
#define N 10

int main(void)
{
	int a[N];
	int total;
	int i;

	for (i = 0; i < N; i++)
	{
		a[i] = i;
	}

	total = 0;
	for (i = 0; i<N; i++)
	{
#ifdef DEBUG
		printf("%d\n", a[i]);
#endif
		total += a[i];
	}

	printf("Total = %d\n", total);
	return 0;
}