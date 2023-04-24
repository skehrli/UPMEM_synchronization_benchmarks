#!/bin/bash
#Barrier benchmarks

numOps=(100)
declare -a main_section=(0 100 200 300 400 500 600 700 800 900 1000)

num_main_sections=${#main_section[@]}
num_critical_sections=${#critical_section[@]}

filename="./benchmarks/barrier_multi_benchmark.csv"

max_tasklets=16
max_barriers=16

#Clear files
rm ${filename}

#For each main_section
for ((ms = 0; ms < num_main_sections; ms++))
do
    #New titel in result file
    titel="tasklets"
    for ((barriers = 1; barriers <= ${max_barriers}; barriers++))
    do
        titel=$titel";"${barriers}"_bc;"${barriers}"_bnc"
    done

    echo "main_section ${main_section[ms]}" >> ${filename}
    echo ${titel} >> ${filename}

    echo "main_section ${main_section[ms]}"
    echo ${titel}

    #For each number of tasklets
    for ((tasklets = 1; tasklets <= ${max_tasklets}; tasklets++))
    do
        line=${tasklets}
        for ((barriers = 1; barriers <= ${tasklets}; barriers++))
        do
            #Run the benchmark
            command="bench bar_kernel_multi_${barriers} ${tasklets} ${numOps} 0 ${main_section[$ms]}"
            if [ -z ${1+x} ]; 
            then 
                result=$(LD_LIBRARY_PATH=./upmem-2021.3.0-Linux-x86_64/lib ./bin/${command})
            else 
                result=$(./bin/${command})
            fi

            #Get cycles
            cycles_str=$(grep 'Maximum Cycles:' <(echo "$result"))
            read -ra split <<<"$cycles_str"

            cycles=${split[2]}
            normalized=${split[6]}

            line=${line}";"${cycles}";"${normalized}
        done

        echo ${line} >> ${filename}
        echo ${line}
    done
    echo "" >> ${filename}
    echo ""
done