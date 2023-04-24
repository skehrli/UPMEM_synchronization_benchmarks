#include <barrier.h>
#include <built_ins.h>
#include <defs.h>
#include <mram.h>
#include <perfcounter.h>
#include <stdint.h>
#include <stdio.h>

#include "../support/cyclecount.h"

BARRIER_INIT(my_barrier, NR_TASKLETS);

#ifndef NR_BARRIERS
#define NR_BARRIERS 1
#endif
#ifndef NO_SYNC
ATOMIC_BIT_INIT(barriers_mutexes)[NR_BARRIERS];
barrier_t barriers[NR_BARRIERS];
#endif

typedef struct {
  int num_ops;
  int critical_section;
  int main_section;
  int padding;
} arguments_t;

arguments_t __mram_noinit args;
uint64_t __mram_noinit result_cycles[NR_TASKLETS];

int main() {
  // Read arguments
  arguments_t __dma_aligned wargs;
  mram_read(&args, &wargs, sizeof(arguments_t));

  const sysname_t tasklet_id = me();
#ifndef NO_SYNC
  const unsigned int barrier_id = tasklet_id % NR_BARRIERS;
  // printf("%d %% %d = %d\n", tasklet_id, NR_BARRIERS, tasklet_id %
  // NR_BARRIERS);
#endif
  if (tasklet_id == 0) {
#ifndef NO_SYNC
    // Initialize barriers
    const int tasklets_per_barrier =
        (NR_TASKLETS + NR_BARRIERS - 1) / NR_BARRIERS;

    for (unsigned int each_barrier = 0; each_barrier < NR_BARRIERS;
         each_barrier++) {
      barriers[each_barrier].wait_queue = 0xff;
      if (each_barrier == NR_BARRIERS - 1) {
        const int tasklets_using_last_barrier =
            NR_TASKLETS - (NR_BARRIERS - 1) * tasklets_per_barrier;
        barriers[each_barrier].count = tasklets_using_last_barrier;
        barriers[each_barrier].initial_count = tasklets_using_last_barrier;
      } else {
        barriers[each_barrier].count = tasklets_per_barrier;
        barriers[each_barrier].initial_count = tasklets_per_barrier;
      }
      barriers[each_barrier].lock =
          (uint8_t)&ATOMIC_BIT_GET(barriers_mutexes)[each_barrier];

      // printf("Barrier %d Count %d\n", each_barrier,
      // barriers[each_barrier].count);
    }
#endif
    /*
    printf("\n");
    for(unsigned int i = 0; i < NR_TASKLETS; i++)
        printf("%d %% %d = %d\n", i, NR_BARRIERS, i % NR_BARRIERS);
    */
    // Reset performance counter
    perfcounter_config(COUNT_CYCLES, true);
  }
  perfcounter_cycles cycles;
  barrier_wait(&my_barrier);

  // Start timer
  timer_start(&cycles);

  // Actual benchmark
  for (int j = tasklet_id; j < wargs.num_ops; j += NR_TASKLETS) {
    for (int i = 0; i < wargs.main_section; i++) {
      __builtin_nop_();
    }
#ifndef NO_SYNC
    barrier_wait(&barriers[barrier_id]);
#endif
  }

  // Read performance counter
  uint64_t __dma_aligned total_cycles = timer_stop(&cycles);
  mram_write(&total_cycles, &result_cycles[tasklet_id], sizeof(perfcounter_t));

  return 0;
}
