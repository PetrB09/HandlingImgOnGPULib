#ifndef SMALLMAT_H
#define SMALLMAT_H

class SmallMat
{
public:
	SmallMat(char* data, int rows, int cols, int x, int y, int sizeOfElement);
	char* GetData();
	int GetRows();
	int GetCols();
	~SmallMat();
	char* Data;
private:
	 //pointer to data
	int Rows; //size
	int Cols;
	int SizeOfElement; //numbers byte for one element of array;
	int X; //numbers this patch in big picture
	int Y;
};
#endif
