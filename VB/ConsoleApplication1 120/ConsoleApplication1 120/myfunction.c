#include <stdio.h>
#include "myfunction.h"

int search_min(struct data *ptr, int s, int e)
{
	int min_num;
	int i;

	min_num = s;
	for( i = s + 1; i <= e; i++ )
	{
		if( (ptr + i)->key < (ptr + min_num)->key )
		{
			min_num = i;
		}
	}

	return min_num;
}

void swap(struct data *ptr, int a, int b)
{
	struct data tmp;

	tmp.key = (ptr + b)->key;
	tmp.data1 = (ptr + b)->data1;
	tmp.data2 = (ptr + b)->data2;
	tmp.data3 = (ptr + b)->data3;
	(ptr + b)->key = (ptr + a)->key;
	(ptr + b)->data1 = (ptr + a)->data1;
	(ptr + b)->data2 = (ptr + a)->data2;
	(ptr + b)->data3 = (ptr + a)->data3;
	(ptr + a)->key = tmp.key;
	(ptr + a)->data1 = tmp.data1;
	(ptr + a)->data2 = tmp.data2;
	(ptr + a)->data3 = tmp.data3;

	return;
}

void straight_selection_sort(struct data *ptr, int n)
{
	int min_num;
	int i, j;

	for(i = 0; i < n - 1; i++)
	{
		min_num = search_min(ptr, i, n - 1);
		swap(ptr, i, min_num);
	}

	return;
}

int read_data(struct data *ptr, char *file_name, int max)
{
	FILE *fp;
	int i;

	fp = fopen(file_name, "r");
	if( fp == NULL )
	{
		printf("ƒtƒ@ƒCƒ‹‚ª‚ ‚è‚Ü‚¹‚ñ\n"); 
		return -1;
	}
	for( i = 0; i < max; i++ )
	{
		if( feof(fp) != 0 )
		{
			fclose(fp);
			return i;
		}
		fscanf(fp, "%d,%lf,%lf,%lf", &(ptr + i)->key, &(ptr + i)->data1, &(ptr + i)->data2, &(ptr + i)->data3);
	}
	fclose(fp);
	return i;
}
