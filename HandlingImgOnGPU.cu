
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

void loadtoGPUmem(void** ptr, int size, int height, int width)
{
	cudaMalloc(ptr, size*height*width);
	return;
}
void cutImg(void** ptr, void** ptrs[], int size, int height, int width, int result_height, int result_width)
{
	if(((height%result_height) != 0)||((width%result_width) != 0))
		return;
	for(int i = 0; i<height/result_height; i++)
	{
		for(int j = 0; j< width/result_width; j++)
		{
			cudaMalloc(&ptrs[i*(height/result_height) + j], size*result_height*result_width);
		}
	}
}
