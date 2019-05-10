#include <stdio.h>
#include "myfunction.h"

int main(void)
{
	struct data x[1000];
	int i;
	int n;

	n = read_data(x, "test.csv", 1000);

	for(i = 0; i < n; i++)
	{
		printf("%d ", x[i].key);
	}
	printf("\n");

	straight_selection_sort(x, n);

	for(i = 0; i < n; i++)
	{
		printf("%d ", x[i].key);
	}
	printf("\n");

	return 0;
}

