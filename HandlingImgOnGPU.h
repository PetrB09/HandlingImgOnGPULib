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
#include <BigMat.h>
#include <SmallMat.h>

void loadtoGPUmem(char**, char*, int, int, int);
void deleteFromGPUMem(char*);
void cutImg(char*, BigMat**, int, int, int, int, int);


#endif /* HANDLINGIMGONGPU_H_ */
