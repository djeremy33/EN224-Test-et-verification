#include "stdio.h"
#include "stdlib.h"
#include "assert.h"
#include "pgcd.h"

#define CATCH_CONFIG_MAIN
#include "catch.hpp"

#define NBR_TEST 5


TEST_CASE( "PGCD_n", "[pgcd]"){
	REQUIRE(PGCD(6, 1) == 1);
	REQUIRE(PGCD(4, 10) == 2);
	REQUIRE(PGCD(26, 26) == 26);
}

TEST_CASE("PGCD_p", "[pgcd]"){
	REQUIRE(PGCD(6, 0) == 6);
	REQUIRE(PGCD(0, 10) == 10);
	REQUIRE(PGCD(0, 0) == 0);
}
