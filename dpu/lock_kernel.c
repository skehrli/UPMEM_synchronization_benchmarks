#include <barrier.h>
#include <built_ins.h>
#include <defs.h>
#include <mram.h>
#include <mutex.h>
#include <perfcounter.h>
#include <stdint.h>
#include <stdio.h>

#include "../support/cyclecount.h"

BARRIER_INIT(bar, NR_TASKLETS);
#ifdef NR_LOCKS
uint8_t __atomic_bit locks_atomic_bits[NR_LOCKS];
mutex_id_t locks[NR_LOCKS];
#else
MUTEX_INIT(lock);
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

  // Reset performance counter
  const sysname_t tasklet_id = me();
#ifdef NR_LOCKS
  const int lock_id = tasklet_id % NR_LOCKS;
#endif
  if (tasklet_id == 0) {
#ifdef NR_LOCKS
    for (int each_lock = 0; each_lock < NR_LOCKS; each_lock++) {
      locks[each_lock] = &locks_atomic_bits[each_lock];
      // printf("Lock %d: %d\n", each_lock, locks[each_lock]);
    }
#endif
    perfcounter_config(COUNT_CYCLES, true);
  }
  perfcounter_cycles cycles;
  barrier_wait(&bar);

  // Start timer
  timer_start(&cycles);

  // Actual benchmark
  for (int j = tasklet_id; j < wargs.num_ops; j += NR_TASKLETS) {
#ifndef NO_SYNC
#ifdef NR_LOCKS
    mutex_lock(locks[lock_id]);
#else
    mutex_lock(lock);
#endif
#endif
    for (int i = 0; i < wargs.critical_section; i++) {
      __builtin_nop_();
    }
#ifndef NO_SYNC
#ifdef NR_LOCKS
    mutex_unlock(locks[lock_id]);
#else
    mutex_unlock(lock);
#endif
#endif
    for (int i = 0; i < wargs.main_section; i++) {
      __builtin_nop_();
    }
  }

  // Read performance counter
  uint64_t __dma_aligned total_cycles = timer_stop(&cycles);
  mram_write(&total_cycles, &result_cycles[tasklet_id], sizeof(perfcounter_t));

  return 0;
}
