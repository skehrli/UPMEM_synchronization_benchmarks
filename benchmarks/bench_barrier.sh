#!/bin/bash
#Barrier benchmarks

numOps=(1000)
declare -a main_section=(0 100 200 300 400 500 600 700 800 900 1000)

num_main_sections=${#main_section[@]}
num_critical_sections=${#critical_section[@]}

filename="./benchmarks/barrier_benchmark.csv"

#Clear files
rm ${filename}

#For each main_section
for ((ms = 0; ms < num_main_sections; ms++))
do
    #New title in result file
    echo "main_section ${main_section[ms]}" >> ${filename}
    echo "tasklets;cycles;normalized_cycles;no_sync_cycles;no_sync_normalized_cycles" >> ${filename}

    echo "main_section ${main_section[ms]}"
    echo "tasklets;cycles;normalized_cycles;no_sync_cycles;no_sync_normalized_cycles"

    #For each number of tasklets
    for ((tasklets = 1; tasklets <= 16; tasklets++))
    do
        #Run the benchmark
        command="bench bar_kernel ${tasklets} ${numOps} 0 ${main_section[$ms]}"
        command_nosync="bench bar_kernel_nosync ${tasklets} ${numOps} 0 ${main_section[$ms]}"
        if [ -z ${1+x} ]; 
        then 
            result=$(LD_LIBRARY_PATH=./upmem-2021.3.0-Linux-x86_64/lib ./bin/${command})
            result_nosync=$(LD_LIBRARY_PATH=./upmem-2021.3.0-Linux-x86_64/lib ./bin/${command_nosync})
        else 
            result=$(./bin/${command})
            result_nosync=$(./bin/${command_nosync})
        fi

        #Get cycles
        cycles_str=$(grep 'Maximum Cycles:' <(echo "$result"))
        cycles_str_nosync=$(grep 'Maximum Cycles:' <(echo "$result_nosync"))
        read -ra split <<<"$cycles_str"
        read -ra split_nosync <<<"$cycles_str_nosync"

        cycles=${split[2]}
        cycles_nosync=${split_nosync[2]}
        normalized=${split[6]}
        normalized_nosync=${split_nosync[6]}

        echo ${tasklets}";"${cycles}";"${normalized}";"${cycles_nosync}";"${normalized_nosync} >> ${filename}
        echo ${tasklets}";"${cycles}";"${normalized}";"${cycles_nosync}";"${normalized_nosync}
    done
    echo "" >> ${filename}
    echo ""
done