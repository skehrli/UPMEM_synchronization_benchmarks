#!/bin/bash
make clean

#Compile benchmarks
for ((tasklets = 1; tasklets <= 16; tasklets++))
do
    #Compile benchmarks
    if [ -z ${1+x} ]; 
    then 
        #Compile for simulator
        make lock -e NR_TASKLETS=${tasklets}
        for ((locks_barriers = 1; locks_barriers <= tasklets; locks_barriers++))
        do
            make lock_multi -e NR_TASKLETS=${tasklets} -e NR_LOCKS=${locks_barriers}
            make barrier_multi -e NR_TASKLETS=${tasklets} -e NR_BARRIERS=${locks_barriers}
            make semaphore -e NR_TASKLETS=${tasklets} -e NR_SEMAPHORES=${locks_barriers}
        done
        make barrier -e NR_TASKLETS=${tasklets}
        if [ "$tasklets" -lt 9 ];
        then
            make handshake -e NR_TASKLETS=$(($tasklets + $tasklets))
        fi
    else 
        #Compile for server
        make lock_server -e NR_TASKLETS=${tasklets}
        for ((locks_barriers = 1; locks_barriers <= tasklets; locks_barriers++))
        do
            make lock_multi_server -e NR_TASKLETS=${tasklets} -e NR_LOCKS=${locks_barriers}
            make barrier_multi_server -e NR_TASKLETS=${tasklets} -e NR_BARRIERS=${locks_barriers}
            make semaphore_server -e NR_TASKLETS=${tasklets} -e NR_SEMAPHORES=${locks_barriers}
        done
        make barrier_server -e NR_TASKLETS=${tasklets}
        if [ "$tasklets" -lt 9 ];
        then
            make handshake_server -e NR_TASKLETS=$(($tasklets + $tasklets))
        fi
    fi
done