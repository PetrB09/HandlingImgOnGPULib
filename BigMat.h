#ifndef BIGMAT_H
#define BIGMAT_H

#include <SmallMat.h>

class BigMat
{
public:
	BigMat(int Rows, int Cols);
	~BigMat();
	void SetData(SmallMat* data);
	SmallMat* Mats;
private:

	int Rows;
	int Cols;
	int Numbers;
};

#endif
