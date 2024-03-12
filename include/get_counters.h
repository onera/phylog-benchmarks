#include <time.h> 
#include <sys/time.h>

#if TIMECHOICE == PMU
#include "PMU.h"
#endif 

#ifndef PCMCOUNTER1
#define PCMCOUNTER1 0x2
#endif 
#ifndef PCMCOUNTER2
#define PCMCOUNTER2 0x3
#endif 

typedef struct event_to_track_struct{
  volatile int id_event1;
  volatile int id_event2;
} event_to_track_struct;

volatile struct event_to_track_struct events_to_track = {EVENT1, EVENT2};

typedef struct counters_record{
  volatile unsigned long cycle;
  volatile struct timeval tv;
  volatile unsigned long clock;
  volatile unsigned long ev1;
  volatile unsigned long ev2;
} counters_record;


////////////////////////////////////////////////////////////////////
void set_event1(int id_evt1) {
  events_to_track.id_event1 = id_evt1;
}

void set_event2(int id_evt2) {
  events_to_track.id_event2 = id_evt2;
}
////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////
struct counters_record get_counters_start() {
 volatile counters_record prof ;
#if TIMECHOICE == PMU
 int id_counter1 = PMCOUNTER1;
 int id_event1 = events_to_track.id_event1;
 select_counter(id_counter1);
 select_event(id_event1); 

 int id_counter2 = PMCOUNTER2;
 int id_event2 = events_to_track.id_event2;
 select_counter(id_counter2);
 select_event(id_event2);

 gettimeofday(&(prof.tv), NULL);
 enable_cycle_counter()  ;
 reset_cycle_counter(0); 
 prof.cycle= (unsigned long) read_cycle_counter();  
  
 select_counter(id_counter1);
 reset_all_counters(0);
 
 prof.ev1 =read_counter();
  
 select_counter(id_counter12); 
 prof.ev2 =read_counter();
 
 enable_all_counters();
#elif TIMECHOICE == CLOCK
 prof.clock = (unsigned long) clock();
#endif 
 return prof ;
}
////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////
struct counters_record get_counters_stop() {
  volatile counters_record prof ;
#if TIMECHOICE == PMU
 int id_counter2 = PMCOUNTER2;
    disable_all_counters();
    select_counter(PMCOUNTER2);
    prof.ev2 =read_evt_counter();
     
 int id_counter1 = PMCOUNTER1;
    select_counter(PMCOUNTER1); 
    prof.ev1 =read_evt_counter();

    prof.cycle= (unsigned long) read_cycle_counter(); 
    gettimeofday(&(prof.tv), NULL);
 
#elif TIMECHOICE == CLOCK
    prof.clock = (unsigned long) clock();
#endif 
   return prof; 
}
////////////////////////////////////////////////////////////////////

  
////////////////////////////////////////////////////////////////////
void print_counters (int iter, counters_record start, counters_record end )  {
#if TIMECHOICE == PMU
  unsigned long ret1 =  start.tv.tv_usec;
  ret1 += (start.tv.tv_sec * 1000000);
  unsigned long ret2 =  end.tv.tv_usec;
  ret2 += (end.tv.tv_sec * 1000000);
  printf("%d (iter/stride)    %ld (cycle)    %ld (evt1)    %ld (evt2)    %ld (us)    %f (ghz) ", 
      iter,  end.cycle-start.cycle,  end.ev1-start.ev1 , end.ev2-start.ev2  ,  ret2-ret1, (end.cycle-start.cycle)/ (1000.0*(ret2-ret1)) );
#elif TIMECHOICE == CLOCK
  printf("%d (iter/stride)   -- (cycle)    -- (evt1)    -- (evt2)    %ld (us)    -- (ghz) ", iter,  end.clock - start.clock );
#endif
   printf ("\n"); 
}
////////////////////////////////////////////////////////////////////

