#include <time.h> 
#include <sys/time.h>


typedef struct counters_record{
  volatile unsigned long cycle;
  volatile struct timeval tv;
  volatile unsigned long clock;
} counters_record;



////////////////////////////////////////////////////////////////////
struct counters_record get_counters_start() {
 volatile counters_record prof = {0};
#if TIMECHOICE == CLOCK
 prof.clock = (unsigned long) clock();
#endif 
 return prof ;
}
////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////
struct counters_record get_counters_stop() {
  volatile counters_record prof = {0};
#if TIMECHOICE == CLOCK
    prof.clock = (unsigned long) clock();
#endif 
   return prof; 
}
////////////////////////////////////////////////////////////////////

  
////////////////////////////////////////////////////////////////////
void print_counters (int iter, counters_record start, counters_record end )  {
#if TIMECHOICE == CLOCK
  printf("%d (iter/stride)   -- (cycle)    -- (evt1)    -- (evt2)    %ld (us)    -- (ghz) ", iter,  end.clock - start.clock );
#endif
   printf ("\n"); 
}
////////////////////////////////////////////////////////////////////

