struct data
{
	int key;
	double data1;
	double data2;
	double data3;
};

int search_min(struct data *, int, int);
void swap(struct data *, int, int);
void straight_selection_sort(struct data *, int);
int read_data(struct data *, char *, int);
