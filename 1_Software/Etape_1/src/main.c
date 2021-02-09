#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include "assert.h"

int PGCD(int A, int B)
{
	while(A != B){
		if(A>B)
			A = A - B;
		else
			B = B - A;
	}
	return A;
}

int main (int argc, char * argv []){
	printf("(II) Starting PGCD program\n");
	assert(PGCD(96, 36) == 12);
	assert(PGCD(100, 10) == 10);
	assert(PGCD(64, 16) == 16);
	assert(PGCD(221, 782) == 17);
	assert(PGCD(1000, 32)== 8);
	assert(PGCD(56142, 237) == 3);
	assert(PGCD(2389, 726) == 1);
	assert(PGCD(26, 6589) == 1);
	assert(PGCD(56, 9869) == 1);
	assert(PGCD(45, 326) == 1);
	assert(PGCD(32, 2156) == 4);
	assert(PGCD(6, 120) == 6);
	
	printf("(II) End of PGCD program\n");
  return 0;
}
