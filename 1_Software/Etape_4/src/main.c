#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include "assert.h"
#include "time.h"

#define NBR_TEST 11500
#define BORNEINF 1
#define BORNESUP 65535

int PGCD(int A, int B)
{			
	printf("PGCD de %d et %d est égale à ", A, B);

	assert(A >= BORNEINF && A <= BORNESUP);
	assert(B >= BORNEINF && B <= BORNESUP);
	
	if(A==0)
		return B;
	else if(B==0)
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
	return rand()%BORNESUP;
}

//Lorsqu'on utilise le programme avec dndebug cela ne nous empeche pas d'avoir des cas interdit
int main (int argc, char * argv []){
	int a, b;
	// srand(time(NULL));
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
