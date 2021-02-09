#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include "assert.h"
#include "time.h"

#define NBR_TEST 65535
#define BORNE_MAX 65535

int PGCD(int A, int B)
{			
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

int PGCD_euclide(int A, int B)
{			
	int C = 0;
	if(A == 0)
		return B;
	else if(B == 0)
		return A;

	while(B != 0){
		C = A % B;
		A = B;
		B = C;
	}
	return A;
}

int myRand(){
	return rand()%BORNE_MAX;
}
//Implementation d'un nouvel algorithme de calcul de pgcd, il est très rare que les deux algorithmes renvoyent la même erreur ce qui nous permet de tester les valeurs automatiquement
int main (int argc, char * argv []){
	int a, b, r1, r2;
	// srand(time(NULL));
	printf("(II) Starting PGCD program\n");

	for(int i = 0; i < NBR_TEST; i++){
		a = myRand();
		b = myRand();
		r1 = PGCD(a,b);
		r2 = PGCD_euclide(a, b);
		if(r1 != r2)
			printf("Erreur avec a=%d et b=%d, les résultats sont PGCD=%d et PGCD_eu=%d\n", a, b, r1, r2);
	}
	
	printf("(II) End of PGCD program\n");
  return 0;
}
