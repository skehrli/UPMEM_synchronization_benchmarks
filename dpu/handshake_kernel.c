#include <stdint.h>
#include <stdio.h>
#include <perfcounter.h>
#include <built_ins.h>
#include <mram.h>
#include <defs.h>
#include <barrier.h>
#include <handshake.h>

#include "cyclecount.h"

BARRIER_INIT(bar, NR_TASKLETS)

typedef struct {
    int num_ops;
    int critical_section;
    int main_section;
    int padding;
} arguments_t;

arguments_t __mram_noinit args;
uint64_t __mram_noinit result_cycles[NR_TASKLETS];

//For odd tasklet ids
void producer(arguments_t* wargs) {
    for(int j = 0; j < wargs->num_ops; j++) {
        for(int i = 0; i < wargs->critical_section; i++) {
            __builtin_nop_();
        }

        handshake_notify();
    }
}

//For even tasklet ids
void consumer(arguments_t* wargs, sysname_t tasklet_id) {
    //Actual benchmark
    for(int j = 0; j < wargs->num_ops; j++) {
        handshake_wait_for(tasklet_id + 1); //Wait for next odd tasklet

        for(int i = 0; i < wargs->main_section; i++) {
            __builtin_nop_();
        }
    }
}

int main() {
    //Read arguments
    arguments_t __dma_aligned wargs;
    mram_read(&args, &wargs, sizeof(arguments_t));

    //Reset performance counter
    const sysname_t tasklet_id = me();
    if(tasklet_id == 0) {
        perfcounter_config(COUNT_CYCLES, true);
    }
    perfcounter_cycles cycles;
    barrier_wait(&bar);

    //Start timer
    timer_start(&cycles);
    
    if(tasklet_id % 2 == 0) {
        //Even tasklet id
        consumer(&wargs, tasklet_id);
    }
    else {
        //Odd tasklet id
        producer(&wargs);
    }

    //Read performance counter
    uint64_t __dma_aligned total_cycles = timer_stop(&cycles);
    mram_write(&total_cycles, &result_cycles[tasklet_id], sizeof(perfcounter_t));

    return 0;
}