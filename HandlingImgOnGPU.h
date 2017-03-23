/*
 * HandlingImgOnGPU.h
 *
 *  Created on: 11 марта 2017 г.
 *      Author: petr
 */

#ifndef HANDLINGIMGONGPU_H_
#define HANDLINGIMGONGPU_H_

#include <cuda.h>
#include <vector_types.h>

void loadtoGPUmem(uchar4***, int, int, uchar4***);
void deleteFromGPUMem(uchar4***, int, int);
void cutImg(uchar4***, uchar4***, int, int, int, int, int);
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
class BigMat
{
public:
	BigMat(int Rows, int Cols);
	~BigMat();
	void SetData(SmallMat* data);
	SmallMat* Mats;
private:

	int Rows;
	int Cols;
	int Numbers;
};
#endif /* HANDLINGIMGONGPU_H_ */
