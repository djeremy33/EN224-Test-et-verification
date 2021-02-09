#include <stdio.h>
#include "stdlib.h"
#include "assert.h"
#include "pgcd.h"

#define NBR_TEST 65536

int main (int argc, char * argv []){
	int retour;
	FILE *ref_a = fopen("./src/ref_A.txt", "r");
	if(ref_a == NULL)	return EXIT_FAILURE;

	FILE *ref_b = fopen("./src/ref_B.txt", "r");
	if(ref_b == NULL)	return EXIT_FAILURE;

	FILE *resu_c = fopen("./src/resu_C.txt", "w"); 
	if(resu_c == NULL)	return EXIT_FAILURE;


	printf("(II) Starting PGCD program\n");
	int a;
	int b;
	int c;
	char result[10];
	for( int i = 0; i < NBR_TEST-1; i++){
		retour = fscanf(ref_a, "%d\n", &a);
		retour = fscanf(ref_b, "%d\n", &b);
		c = PGCD(a,b);
		sprintf(result, "%d", c);
		fprintf(resu_c, "%s\r\n", result);
	}
	retour = fscanf(ref_a, "%d", &a);
	retour = fscanf(ref_b, "%d", &b);
	c = PGCD(a,b);
	sprintf(result, "%d", c);
	fprintf(resu_c, "%s", result);
	
	printf("(II) End of PGCD program\n");

	fclose(ref_a);
	fclose(ref_b);
	fclose(resu_c);

  return 0;
}
