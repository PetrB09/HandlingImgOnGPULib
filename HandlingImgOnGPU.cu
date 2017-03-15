
/**
 * Copyright 1993-2012 NVIDIA Corporation.  All rights reserved.
 *
 * Please refer to the NVIDIA end user license agreement (EULA) associated
 * with this source code for terms and conditions that govern your use of
 * this software. Any use, reproduction, disclosure, or distribution of
 * this software and related documentation outside the terms of the EULA
 * is strictly prohibited.
 */
#include <stdio.h>
#include <stdlib.h>
#include <vector>
#include <HandlingImgOnGPU.h>

//#include <cuda.h>

//static const int WORK_SIZE = 256;

/**
 * This macro checks return value of the CUDA runtime call and exits
 * the application if the call failed.
 *
 * See cuda.h for error code descriptions.
 */
#define CHECK_CUDA_RESULT(N) {											\
	CUresult result = N;												\
	if (result != 0) {													\
		printf("CUDA call on line %d returned error %d\n", __LINE__,	\
			result);													\
		exit(1);														\
	} }
/**
 *input_ptr - pointer to sourse array
 *arrOfPtr - pointer to array of pointers to memory for copies
 *size - size of element of sourse array
 *height - height of sourse image
 *width - width of sourse image
 *newHeight - height of new image
 *newWidth - width of new image
 */
__global__ void cuttingIMG(uchar4*** input_ptr, uchar4*** arrOfPtr, int newHeight, int newWidth)
{
	int NumberThread = blockIdx.x * blockDim.x + threadIdx.x; //linear address of thread

	uchar4** NewArr = arrOfPtr[NumberThread]; //pointer to new array

	for(int i = 0; i<newHeight; i++)
	{
		for(int j = 0; j<newWidth; j++)
		{
			NewArr[i][j] = *(input_ptr) [blockIdx.x * newHeight + i][threadIdx.x * newWidth + j];
		}
	}
}

void loadtoGPUmem(uchar4*** d_ptr, int height, int width, uchar4*** src)
{
	cudaMalloc(*d_ptr, sizeof(uchar4*)*height);
	for(int i = 0; i<height; i++)
	{
		cudaMalloc(d_ptr[i], sizeof(uchar4) * width);
		cudaMemcpy(d_ptr[i], (*src)[i], sizeof(uchar4) * width, cudaMemcpyHostToDevice);
	}
	return;
}

void deleteFromGPUMem(uchar4*** d_ptr, int height, int width)
{
	uchar4** Arr = *d_ptr;
	for(int i = 0; i<height; i++)
	{
		cudaFree(Arr[i]);
	}
	cudaFree(Arr);
	cudaFree(d_ptr);
}

void cutImg(uchar4*** d_ptr, uchar4*** arrOfPointers, int height, int width, int numbersPatchesH, int numbersPatchesW)
{
	if((height % numbersPatchesH) != 0)//1) проверяем делимость размеров на число фрагментов
		return;
	if((width % numbersPatchesW) != 0)
		return;

	int newSizeH = height/numbersPatchesH;
	int newSizeW = width/numbersPatchesW;
	int sizeArrOfPointers = numbersPatchesH * numbersPatchesW;
	cudaMalloc(&(arrOfPointers), sizeof(uchar4**) * sizeArrOfPointers);
	for(int i = 0; i<sizeArrOfPointers; i++)//2) выделяем память, записывая указатели в массив
	{
		cudaMalloc(&(arrOfPointers[i]), sizeof(uchar4*) * newSizeH);
		for(int j = 0; j<newSizeH; j++)
		{
			cudaMalloc(&(arrOfPointers[i][j]), sizeof(uchar4)*newSizeW);
		}
	}
	cuttingIMG<<<numbersPatchesH, numbersPatchesW>>>(d_ptr, arrOfPointers, newSizeH, newSizeW);

}
