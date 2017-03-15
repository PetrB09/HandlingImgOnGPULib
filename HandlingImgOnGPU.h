/*
 * HandlingImgOnGPU.h
 *
 *  Created on: 11 марта 2017 г.
 *      Author: petr
 */

#ifndef HANDLINGIMGONGPU_H_
#define HANDLINGIMGONGPU_H_

#include <cuda.h>

void loadtoGPUmem(uchar4***, int, int, uchar4***);
void deleteFromGPUMem(uchar4***, int, int);
void cutImg(uchar4***, uchar4***, int, int, int, int);
#endif /* HANDLINGIMGONGPU_H_ */
