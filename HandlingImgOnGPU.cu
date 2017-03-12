
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
#include <mem.h>;

#include <cuda.h>

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
__global__ void cuttngIMG(void* input_ptr, void** arrOfPtr, int size, int height, int width, int newHeight, int newWidth)
{
	int NumberThread = blockIdx.x * blockDim.x + threadIdx.x; //linear address of thread
	int SizeNewImg = newHeight * newWidth * size; //size of new picture
	void* SrcElement = input_ptr + blockIdx.x * SizeNewImg + newWidth * size * threadIdx; //input pointer + all blocks which are highly + all elements which are rightly
	void* NewElement = *(arrOfPtr + NumberThread * sizeof(void*));
	for(int i = 0; i<newHeight; i++)
	{
		for(int j = 0; j<newWidth; j++)
		{
			memCpy()
			NewElement += size;
			SrcElement += size;
		}
	}
}

void loadtoGPUmem(void* d_ptr, int size, int height, int width, void* src)
{
	cudaMalloc(&d_ptr, size*height*width);
	cudaMemcpy(&d_ptr, src, size*height*width, cudaMemcpyHostToDevice);
	return;
}

void deleteFromGPUMem(void* d_ptr)
{
	cudaFree(d_ptr);
}

void cutImg(void* d_ptr, void** arrOfPointers, int height, int width, int numbersPatchesH, int numbersPatchesW, int size)
{
	if((height % numbersPathchesH) != 0)//1) проверяем делимость размеров на число фрагментов
		return;
	if((width % numbersPatchesW) != 0)
		return;

	int newSizeH = height/numbersPatchesH;
	int newSizeW = width/numbersPatchesW;
	int sizeArrOfPointers = numbersPatchesH * numbersPatchesW;
	for(int i = 0; i<sizeArrOfPointers; i++)//2) выделяем память, записывая указатели в массив
	{
		cudaMalloc(&(arrOfPointers + i * sizeof(void*)), newSizeH*newSizeW*size);
	}

	//3) запускаем копирование
}

