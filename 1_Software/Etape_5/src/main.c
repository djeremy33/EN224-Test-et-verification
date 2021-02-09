#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include "assert.h"
#include "time.h"

#define NBR_TEST 65535
#define BORNEINF 0
#define BORNESUP 65535

int PGCD(int A, int B)
{			
	int a = A;
	int b = B;
	assert(a >= BORNEINF && a <= BORNESUP);
	assert(b >= BORNEINF && b <= BORNESUP);
	
	if(a==0)
		return b;
	else if(b==0)
		return a;
		
	while(a != b){
		if(a>b)
			a = a - b;
		else
			b = b - a;
	}

	assert(a > BORNEINF && a <= BORNESUP);
	assert(a <=A);
	assert(b <=B);
	assert(A%a == 0);
	assert(B%a == 0);
	return a;
}

int myRand(){
	return rand()%(BORNESUP+1);
}

//Lorsqu'on utilise le programme avec dndebug cela ne nous empeche pas d'avoir des cas interdit
int main (int argc, char * argv []){
	int a, b;
	// srand(time(NULL));
	printf("(II) Starting PGCD program\n");
	for(int i = 0; i < NBR_TEST; i++){
		a = myRand();
		b = myRand();
		PGCD(a,b);
	}
	
	printf("(II) End of PGCD program\n");
  return 0;
}
