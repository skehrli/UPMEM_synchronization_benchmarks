DPU_DIR := dpu
HOST_DIR := host
BUILDDIR ?= bin
NR_TASKLETS ?= 8
NR_DPUS ?= 4
NR_LOCKS ?= 2
NR_SEMAPHORES ?= 8
NR_BARRIERS ?= 1
CC := gcc

COMMON_INCLUDES := support
HOST_SOURCES := $(wildcard ${HOST_DIR}/*.c)

.PHONY: barrier barrier_multi barrier_server barrier_multi_server lock lock_server lock_multi lock_multi_server handshake handshake_server semaphore clean test_barrier test_lock test_lock_multi test_handshake

__dirs := $(shell mkdir -p ${BUILDDIR})

barrier_server: HOST_FLAGS += -DBAR `dpu-pkg-config --cflags --libs dpu`
barrier_server: dpu_barrier_server host_server

barrier_multi_server: HOST_FLAGS += -DBAR `dpu-pkg-config --cflags --libs dpu`
barrier_multi_server: dpu_barrier_multi_server host_server

lock_server: HOST_FLAGS += -DLOCK `dpu-pkg-config --cflags --libs dpu`
lock_server: dpu_lock_server host_server

lock_multi_server: HOST_FLAGS += -DLOCK `dpu-pkg-config --cflags --libs dpu`
lock_multi_server: dpu_lock_multi_server host_server

handshake_server: HOST_FLAGS += -DHANDSHAKE `dpu-pkg-config --cflags --libs dpu`
handshake_server: dpu_handshake_server host_server

semaphore_server: HOST_FLAGS += `dpu-pkg-config --cflags --libs dpu`
semaphore_server: dpu_semaphore_server host_server

barrier: HOST_FLAGS += -DBAR -I ./upmem-2023.1.0-Linux-x86_64/include/dpu -L ./upmem-2023.1.0-Linux-x86_64/lib64 -ldpu -ldpuverbose
barrier: dpu_barrier host

barrier_multi: HOST_FLAGS += -DBAR -I ./upmem-2023.1.0-Linux-x86_64/include/dpu -L ./upmem-2023.1.0-Linux-x86_64/lib64 -ldpu -ldpuverbose
barrier_multi: dpu_barrier_multi host

lock: HOST_FLAGS += -DLOCK -I ./upmem-2023.1.0-Linux-x86_64/include/dpu -L ./upmem-2023.1.0-Linux-x86_64/lib64 -ldpu -ldpuverbose
lock: dpu_lock host

lock_multi: HOST_FLAGS += -DLOCK -I ./upmem-2023.1.0-Linux-x86_64/include/dpu -L ./upmem-2023.1.0-Linux-x86_64/lib64 -ldpu -ldpuverbose
lock_multi: dpu_lock_multi host

handshake: HOST_FLAGS += -DHANDSHAKE -I ./upmem-2023.1.0-Linux-x86_64/include/dpu -L ./upmem-2023.1.0-Linux-x86_64/lib64 -ldpu -ldpuverbose
handshake: dpu_handshake host

semaphore: HOST_FLAGS += -I ./upmem-2023.1.0-Linux-x86_64/include/dpu -L ./upmem-2023.1.0-Linux-x86_64/lib64 -ldpu -ldpuverbose
semaphore: dpu_semaphore host

COMMON_FLAGS := -Wall -Wextra -g -I${COMMON_INCLUDES}
HOST_FLAGS := ${COMMON_FLAGS} -std=c11 -O3 -DNR_TASKLETS=${NR_TASKLETS}
DPU_FLAGS := ${COMMON_FLAGS} -O2 -DNR_TASKLETS=${NR_TASKLETS} 

host: ${HOST_SOURCES}
	ccache $(CC) -o ./${BUILDDIR}/bench ${HOST_SOURCES} ${HOST_FLAGS}

host_server: ${HOST_SOURCES}
	$(CC) -o ./${BUILDDIR}/bench ${HOST_SOURCES} ${HOST_FLAGS}

dpu_barrier_server: ${COMMON_INCLUDES}
	dpu-upmem-dpurte-clang ${DPU_FLAGS} -o ./${BUILDDIR}/bar_kernel_${NR_TASKLETS} ./${DPU_DIR}/bar_kernel.c
	dpu-upmem-dpurte-clang ${DPU_FLAGS} -DNO_SYNC -o ./${BUILDDIR}/bar_kernel_nosync_${NR_TASKLETS} ./${DPU_DIR}/bar_kernel.c

dpu_barrier_multi_server: ${COMMON_INCLUDES}
	dpu-upmem-dpurte-clang ${DPU_FLAGS} -DNR_BARRIERS=${NR_BARRIERS} -o ./${BUILDDIR}/bar_kernel_multi_${NR_BARRIERS}_${NR_TASKLETS} ./${DPU_DIR}/bar_kernel.c

dpu_lock_server: ${COMMON_INCLUDES}
	dpu-upmem-dpurte-clang ${DPU_FLAGS} -o ./${BUILDDIR}/lock_kernel_${NR_TASKLETS} ./${DPU_DIR}/lock_kernel.c
	dpu-upmem-dpurte-clang ${DPU_FLAGS} -DNO_SYNC -o ./${BUILDDIR}/lock_kernel_nosync_${NR_TASKLETS} ./${DPU_DIR}/lock_kernel.c

dpu_lock_multi_server: ${COMMON_INCLUDES}
	dpu-upmem-dpurte-clang ${DPU_FLAGS} -DNR_LOCKS=${NR_LOCKS} -o ./${BUILDDIR}/lock_kernel_multi_${NR_LOCKS}_${NR_TASKLETS} ./${DPU_DIR}/lock_kernel.c

dpu_handshake_server: ${COMMON_INCLUDES}
	dpu-upmem-dpurte-clang ${DPU_FLAGS} -o ./${BUILDDIR}/handshake_kernel_${NR_TASKLETS} ./${DPU_DIR}/handshake_kernel.c

dpu_semaphore_server: ${COMMON_INCLUDES}
	dpu-upmem-dpurte-clang ${DPU_FLAGS} -DNR_SEMAPHORES=${NR_SEMAPHORES} -o ./${BUILDDIR}/sem_kernel_${NR_SEMAPHORES}_${NR_TASKLETS} ./${DPU_DIR}/sem_kernel.c
	dpu-upmem-dpurte-clang ${DPU_FLAGS} -DNO_SYNC -DNR_SEMAPHORES=${NR_SEMAPHORES} -o ./${BUILDDIR}/sem_kernel_nosync_${NR_SEMAPHORES}_${NR_TASKLETS} ./${DPU_DIR}/sem_kernel.c

dpu_barrier: ${COMMON_INCLUDES}
	./upmem-2023.1.0-Linux-x86_64/upmem_env.sh
	./upmem-2023.1.0-Linux-x86_64/bin/dpu-upmem-dpurte-clang ${DPU_FLAGS} -o ./${BUILDDIR}/bar_kernel_${NR_TASKLETS} ./${DPU_DIR}/bar_kernel.c
	./upmem-2023.1.0-Linux-x86_64/bin/dpu-upmem-dpurte-clang ${DPU_FLAGS} -DNO_SYNC -o ./${BUILDDIR}/bar_kernel_nosync_${NR_TASKLETS} ./${DPU_DIR}/bar_kernel.c

dpu_barrier_multi: ${COMMON_INCLUDES}
	./upmem-2023.1.0-Linux-x86_64/upmem_env.sh
	./upmem-2023.1.0-Linux-x86_64/bin/dpu-upmem-dpurte-clang ${DPU_FLAGS} -DNR_BARRIERS=${NR_BARRIERS} -o ./${BUILDDIR}/bar_kernel_multi_${NR_BARRIERS}_${NR_TASKLETS} ./${DPU_DIR}/bar_kernel.c

dpu_lock: ${COMMON_INCLUDES}
	./upmem-2023.1.0-Linux-x86_64/upmem_env.sh
	./upmem-2023.1.0-Linux-x86_64/bin/dpu-upmem-dpurte-clang ${DPU_FLAGS} -o ./${BUILDDIR}/lock_kernel_${NR_TASKLETS} ./${DPU_DIR}/lock_kernel.c
	./upmem-2023.1.0-Linux-x86_64/bin/dpu-upmem-dpurte-clang ${DPU_FLAGS} -DNO_SYNC -o ./${BUILDDIR}/lock_kernel_nosync_${NR_TASKLETS} ./${DPU_DIR}/lock_kernel.c

dpu_lock_multi: ${COMMON_INCLUDES}
	./upmem-2023.1.0-Linux-x86_64/upmem_env.sh
	./upmem-2023.1.0-Linux-x86_64/bin/dpu-upmem-dpurte-clang ${DPU_FLAGS} -DNR_LOCKS=${NR_LOCKS} -o ./${BUILDDIR}/lock_kernel_multi_${NR_LOCKS}_${NR_TASKLETS} ./${DPU_DIR}/lock_kernel.c

dpu_handshake: ${COMMON_INCLUDES}
	./upmem-2023.1.0-Linux-x86_64/upmem_env.sh
	./upmem-2023.1.0-Linux-x86_64/bin/dpu-upmem-dpurte-clang ${DPU_FLAGS} -o ./${BUILDDIR}/handshake_kernel_${NR_TASKLETS} ./${DPU_DIR}/handshake_kernel.c

dpu_semaphore: ${COMMON_INCLUDES}
	./upmem-2023.1.0-Linux-x86_64/upmem_env.sh
	./upmem-2023.1.0-Linux-x86_64/bin/dpu-upmem-dpurte-clang ${DPU_FLAGS} -DNR_SEMAPHORES=${NR_SEMAPHORES} -o ./${BUILDDIR}/sem_kernel_${NR_SEMAPHORES}_${NR_TASKLETS} ./${DPU_DIR}/sem_kernel.c

clean:
	$(RM) -r $(BUILDDIR)

test_barrier: barrier
	LD_LIBRARY_PATH=./upmem-2023.1.0-Linux-x86_64/lib64 ./bin/bench bar_kernel ${NR_TASKLETS} 100 200 200

test_barrier_multi: barrier_multi
	LD_LIBRARY_PATH=./upmem-2023.1.0-Linux-x86_64/lib64 ./bin/bench bar_kernel_multi_${NR_BARRIERS} ${NR_TASKLETS} 100 100 100

test_lock: lock
	LD_LIBRARY_PATH=./upmem-2023.1.0-Linux-x86_64/lib64 ./bin/bench lock_kernel ${NR_TASKLETS} 100 100 100

test_lock_multi: lock_multi
	LD_LIBRARY_PATH=./upmem-2023.1.0-Linux-x86_64/lib64 ./bin/bench lock_kernel_multi_${NR_LOCKS} ${NR_TASKLETS} 100 100 100

test_handshake: handshake
	LD_LIBRARY_PATH=./upmem-2023.1.0-Linux-x86_64/lib64 ./bin/bench handshake_kernel ${NR_TASKLETS} 100 100 100

test_semaphore: semaphore
	LD_LIBRARY_PATH=./upmem-2023.1.0-Linux-x86_64/lib64 ./bin/bench sem_kernel_${NR_SEMAPHORES} ${NR_TASKLETS} 100 100 100
