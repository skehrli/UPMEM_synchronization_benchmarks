#include <barrier.h>
#include <built_ins.h>
#include <defs.h>
#include <mram.h>
#include <perfcounter.h>
#include <sem.h>
#include <stdint.h>
#include <stdio.h>

#include "../support/cyclecount.h"

SEMAPHORE_INIT(my_semaphore, NR_SEMAPHORES);
BARRIER_INIT(my_barrier, NR_TASKLETS);

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
  if (tasklet_id == 0) {
    // Reset performance counter
    perfcounter_config(COUNT_CYCLES, true);
  }
  perfcounter_cycles cycles;
  barrier_wait(&my_barrier);

  // Start timer
  timer_start(&cycles);

  // Actual benchmark
  for (int i = 0; i < wargs.num_ops; i++) {
#ifndef NO_SYNC
    sem_take(&my_semaphore);
#endif
    for (int j = 0; j < wargs.critical_section; j++) {
      __builtin_nop_();
    }
#ifndef NO_SYNC
    sem_give(&my_semaphore);
#endif
    for (int j = 0; j < wargs.main_section; j++) {
      __builtin_nop_();
    }
  }

  // Read performance counter
  uint64_t __dma_aligned total_cycles = timer_stop(&cycles);
  mram_write(&total_cycles, &result_cycles[tasklet_id], sizeof(perfcounter_t));

  return 0;
}
