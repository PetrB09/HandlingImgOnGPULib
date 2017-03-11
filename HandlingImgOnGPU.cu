
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

/*__global__ void cuttngIMG(void* input_ptr, void** output_ptr, int size, int height, int width)
{
	int num = blockIdx.x * blockDim.x + threadIdx.x; //линейный адрес потока
	int numbers = height * width; //число пикселей
	void* ptr_first = input_ptr + num * numbers * size; //указатель на начало фрагмента
	void* output_ptr_2 = &output_ptr + sizeof(void*) * num;
	for(int i = 0; i<height; i++)
	{
		for(int j = 0; j<width; j++)
		{
			int offset = i*blockDim * width + width * blockIdx.x + j;
			*(output_ptr_2 + i*height + j) = *(ptr_first + offset);
		}
	}
}*/

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

void cutImg(void* d_ptr, void* arrOfPointers, int height, int width, int numbersPatchesH, int numbersPatchesW)
{
	if((height % numbersPathchesH) != 0)//1) проверяем делимость размеров на число фрагментов
		return;
	if((width % numbersPatchesW) != 0)
		return;


	int sizeArrOfPointers = numbersPatchesH * numbersPatchesW;
	for(int i = 0; i<sizeArrOfPointers; i++)
	{

	}
	//2) выделяем память, записывая указатели в массив
	//3) запускаем копирование
}

