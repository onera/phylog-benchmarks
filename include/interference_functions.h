////////////////////////////////////////////////////////////////////
//
// File interference_functions.h
// Prototype of the benchmark functions
//
////////////////////////////////////////////////////////////////////

#ifndef INTERFERENCE_FUNCTIONS
#define INTERFERENCE_FUNCTIONS

   void int_prime_number_factorization (int iter, int mode) ;

   void long_prime_number_factorization (int iter, int mode) ;

   void float_pi_computation (int iter, int mode) ;

   void double_pi_computation (int iter, int mode) ;

   void load_with_add_stride (long * tab, int lg, int stride, int mode) ;

   void load_with_index_chasing (long *tab, int lg, int stride, int mode) ;

   void store_with_add_stride (long * tab, int lg, int stride, int mode) ;

#endif

