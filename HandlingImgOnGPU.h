/*
 * HandlingImgOnGPU.h
 *
 *  Created on: 11 марта 2017 г.
 *      Author: petr
 */

#ifndef HANDLINGIMGONGPU_H_
#define HANDLINGIMGONGPU_H_

void loadtoGPUmem(uchar4*** d_ptr, int height, int width, uchar4*** src);
void deleteFromGPUMem(uchar4*** d_ptr, int height, int width);
void cutImg(uchar4*** d_ptr, uchar4*** arrOfPointers, int height, int width, int numbersPatchesH, int numbersPatchesW);
__global__ void cuttngIMG(uchar4*** input_ptr, uchar4*** arrOfPtr, int newHeight, int newWidth);
#endif /* HANDLINGIMGONGPU_H_ */
