#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include "assert.h"
#include "time.h"

#define NBR_TEST 20000
#define BORNE_MAX 256

int PGCD(int A, int B)
{			
	printf("PGCD de %d et %d est égale à ", A, B);
	if(A == 0)
		return B;
	else if(B == 0)
		return A;
	while(A != B){
		if(A>B)
			A = A - B;
		else
			B = B - A;
	}
	return A;
}

int myRand(){
	return rand()%BORNE_MAX;
}

//Planter lorsque A ou B était égale a 0
int main (int argc, char * argv []){
	int a, b;
	srand(time(NULL));
	printf("(II) Starting PGCD program\n");

	for(int i = 0; i < NBR_TEST; i++){
		a = myRand();
		b = myRand();
		printf("%d : ", i);
		printf("%d\n", PGCD(a,b));
	}
	
	printf("(II) End of PGCD program\n");
  return 0;
}
