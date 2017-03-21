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
void cutImg(uchar4***, uchar4***, int, int, int, int);
class SmallMat
{
public:
	SmallMat(char* data, int rows, int cols);
	char* GetData();
	int GetRows();
	int GetCols();
private:
	char* Data;
	int Rows;
	int cols;
};
#endif /* HANDLINGIMGONGPU_H_ */
