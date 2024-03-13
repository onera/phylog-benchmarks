// --------------------------------------------
// Parameters to set
// --------------------------------------------
#ifndef PARAMETERS_INCLUDE
#define PARAMETERS_INCLUDE

   // Choice of the time source 
   #define TIMECHOICE CLOCK

   // Minimal number of times the measurements are done
   #define REPEAT 20

   // Depth of the pi computation
   #define PI_COMPUTATION_DEPTH 100000

   // Size of the array used by the load and store micro-benchmarks
   #define SIZE 1048576 // 8 MB

   // Maximal value of stride used by the load and store micro-benchmarks (must be a power of 2)
   #define STRIDE_MAX 2048

   // Value to decompose for the prime number factorization
   #define VALUE_TO_FACTORIZE 21603

#endif
