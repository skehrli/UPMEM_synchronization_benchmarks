#include <stdio.h>
#include <stdlib.h>

#include <assert.h>
#include <dpu.h>

#define LOG 0

typedef struct {
  int num_ops;
  int critical_section;
  int main_section;
  int padding;
} arguments_t;

int main(int argc, char **argv) {
  // Check number of arguments
  if (argc != 6) {
    printf("usage: %s <kernel> <num_tasklets> <num_ops> <critical_section> "
           "<main_section>\n",
           argv[0]);
    return EXIT_FAILURE;
  }

  const int nr_tasklets = atoi(argv[2]);

  // Get arguments
  const arguments_t args = {atoi(argv[3]), // Number of iterations
                            atoi(argv[4]), // Length of critical/serial section
                            atoi(argv[5]), // Length of main/parallel section
                            0};
  char *kernel = malloc(strlen(argv[1]) + strlen(argv[2]) + 8);
  strcpy(kernel, "./bin/");
  strcat(kernel, argv[1]);
  strcat(kernel, "_");
  strcat(kernel, argv[2]);

  printf("the Kernel is: %s\n", kernel);
  fflush(stdout);

  // Init DPU set
  struct dpu_set_t dpu_set, dpu;
  DPU_ASSERT(dpu_alloc(1, "", &dpu_set));      // Allocate DPU
  DPU_ASSERT(dpu_load(dpu_set, kernel, NULL)); // Load kernel
  free(kernel);

  // Copy arguments to dpu
  DPU_ASSERT(dpu_copy_to(dpu_set, "args", 0, &args, sizeof(args)));

  // Run benchmark
  DPU_ASSERT(dpu_launch(dpu_set, DPU_SYNCHRONOUS));

  // Readback performance counter
  uint64_t *pc = malloc(nr_tasklets * sizeof(uint64_t));
  DPU_FOREACH(dpu_set, dpu) {
    uint64_t maximum = 0;
    DPU_ASSERT(dpu_copy_from(dpu, "result_cycles", 0, pc,
                             nr_tasklets * sizeof(uint64_t)));

    for (int each_tasklet = 0; each_tasklet < nr_tasklets; each_tasklet++) {
      if (pc[each_tasklet] > maximum)
        maximum = pc[each_tasklet];
      printf("Tasklet: %d Cycles: %lu\n", each_tasklet, pc[each_tasklet]);
    }
    printf("Maximum Cycles: %lu ", maximum);
    printf("Normalized per Operation: %lu\n", maximum / args.num_ops);
  }
  free(pc);

  // Readback logs
#if LOG
  DPU_FOREACH(dpu_set, dpu) { DPU_ASSERT(dpu_log_read(dpu, stdout)); }
#endif
  // Free DPU set
  DPU_ASSERT(dpu_free(dpu_set));

  return EXIT_SUCCESS;
}
