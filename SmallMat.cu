
/**
 * Copyright 1993-2012 NVIDIA Corporation.  All rights reserved.
 *
 * Please refer to the NVIDIA end user license agreement (EULA) associated
 * with this source code for terms and conditions that govern your use of
 * this software. Any use, reproduction, disclosure, or distribution of
 * this software and related documentation outside the terms of the EULA
 * is strictly prohibited.
 */
#include <HandlingImgOnGPU.h>

SmallMat::SmallMat(char* data, int rows, int cols, int x, int y, int sizeOfElement)
{
	Data = data;
	Rows = rows;
	Cols = cols;
	X = x;
	Y = y;
	SizeOfElement = sizeOfElement;
}

int SmallMat::GetRows()
{
	return Rows;
}
int SmallMat::GetCols()
{
	return Cols;
}
char* SmallMat::GetData()
{
	return Data;
}
SmallMat::~SmallMat()
{
	cudaFree(Data);
}
