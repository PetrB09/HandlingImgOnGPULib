/*
 * HandlingImgOnGPU.h
 *
 *  Created on: 11 марта 2017 г.
 *      Author: petr
 */

#ifndef HANDLINGIMGONGPU_H_
#define HANDLINGIMGONGPU_H_

void loadtoGPUmem(void*, int, int, int, void*);
void deleteFromGPUMem(void*);

#endif /* HANDLINGIMGONGPU_H_ */
