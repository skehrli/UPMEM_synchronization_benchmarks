## Usage
To generate Benchmarks, first compile them with:

```bash
bash benchmarks/compile.sh
```

The compile.sh script compiles the various benchmark source files and also compiles each one for different numbers of tasklets (threads).

The compiled files are in the bin folder. To run the compiled benchmarks, use the following:

```bash
bash benchmarks/<benchmark>.sh
```

Where <benchmark> is a placeholder for the following:
- bench_lock
- bench_lock_multi
- bench_barrier
- bench_barrier_multi
- bench_handshake
- bench_semaphore

The Makefile doesn't have to be touched for compiling and running benchmarks - the compile.sh script makes use of the Makefile.
