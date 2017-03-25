
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
 *input_ptr - pointer to sourse array
 *arrOfPtr - pointer to array of pointers to memory for copies
 *size - size of element of sourse array
 *height - height of sourse image
 *width - width of sourse image
 *newHeight - height of new image
 *newWidth - width of new image
 */
__global__ void cuttingIMG(BigMat* h_output, char* h_input, int newHeight, int newWidth, int sizeOfElem)
{
	int NumberThread = blockIdx.x * blockDim.x + threadIdx.x; //linear address of thread
	int Offset = NumberThread * newHeight * newWidth * sizeOfElem;
	char* OldArr = &(h_input[Offset]); //pointer to start old array
	SmallMat* Worker = &(h_output->Mats[NumberThread]);
	for(int i = 0; i<newHeight * newWidth; i++)
	{
		for(int j = 0; j<sizeOfElem; j++)
		{
			Worker->Data[i+j] = OldArr[i*Offset + j];
		}
	}
}

void loadtoGPUmem(char** d_ptr, char* src, int height, int width, int sizeOfElement)
{
	cudaMalloc(d_ptr, sizeof(char)*height*width*sizeOfElement);
	cudaMemcpy(*d_ptr, src, sizeof(char) * width * height, cudaMemcpyHostToDevice);
	return;
}

void deleteFromGPUMem(char* d_ptr)
{
	cudaFree(d_ptr);
}

void cutImg(char* d_ptr, BigMat** arrOfPatches, int height, int width, int numbersPatchesH, int numbersPatchesW, int sizeOfElement)
{
	if((height % numbersPatchesH) != 0)//1) проверяем делимость размеров на число фрагментов
		return;
	if((width % numbersPatchesW) != 0)
		return;

	int newSizeH = height/numbersPatchesH; //размеры новых картинок
	int newSizeW = width/numbersPatchesW;
	BigMat h_Mats(numbersPatchesH, numbersPatchesW);
	SmallMat* pointer;
	SmallMat** tmp_pointer = &pointer;
	cudaMalloc(tmp_pointer, sizeof(SmallMat)* numbersPatchesH * numbersPatchesW); //память под маленькие картинки
	h_Mats.SetData(pointer);
	cuttingIMG<<<numbersPatchesH, numbersPatchesW>>>(&h_Mats, d_ptr, newSizeH, newSizeW, sizeOfElement);
	//запись новых картинок и указателей на них
	*arrOfPatches = &h_Mats;
	return;
}

