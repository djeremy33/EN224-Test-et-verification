#include "stdio.h"
#include "stdlib.h"
#include "assert.h"
#include "pgcd.h"

#define NBR_TEST 5

//Permet de pouvoir tester le programme pgcd apres un certain temps de travail pour verifier que on a pas fait une erreur dans le nouveau pgcd
int main (int argc, char * argv []){
	int a[NBR_TEST] = {6, 10, 26, 2, 9856};
	int b[NBR_TEST] = {1, 4, 3, 58, 126};
	int r[NBR_TEST] = {1, 2, 1, 2, 14};

	printf("(II) Starting PGCD program\n");

	assert(PGCD(a[0],b[0]) == r[0]);
	assert(PGCD(a[1],b[1]) == r[1]);
	assert(PGCD(a[2],b[2]) == r[2]);
	assert(PGCD(a[3],b[3]) == r[3]);
	assert(PGCD(a[4],b[4]) == r[4]);
	
	printf("(II) End of PGCD program\n");
  return 0;
}
