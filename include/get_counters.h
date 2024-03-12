#include <time.h> 
#include <sys/time.h>

#if TIMECHOICE == CLOCK
#else
    #warn "Unsupported performance counter method" TIMECHOICE
#endif


#ifndef PCMCOUNTER1
#define PCMCOUNTER1 0x0
#endif 
#ifndef PCMCOUNTER2
#define PCMCOUNTER2 0x0
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
#if TIMECHOICE == CLOCK
 prof.clock = (unsigned long) clock();
#endif 
 return prof ;
}
////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////
struct counters_record get_counters_stop() {
  volatile counters_record prof ;
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

