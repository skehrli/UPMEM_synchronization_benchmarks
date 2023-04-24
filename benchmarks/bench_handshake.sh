#!/bin/bash
#Handshake benchmarks

numOps=(100)
declare -a main_section=(0 100 200 300 400 500 600 700 800 900 1000)
declare -a critical_section=(0 100 200 300 400 500 600 700 800 900 1000)

num_main_sections=${#main_section[@]}
num_critical_sections=${#critical_section[@]}

filename="./benchmarks/handshake_benchmark.csv"

#Clear files
rm ${filename}

#For each main_section
for ((ms = 0; ms < num_main_sections; ms++))
do
    #For each critical_section
    for ((cs = 0; cs < num_critical_sections; cs++))
    do
        #New title in result file
        echo "main_section ${main_section[ms]} critical_section ${critical_section[cs]}" >> ${filename}
        echo "tasklets;cycles;normalized_cycles" >> ${filename}

        echo "main_section ${main_section[ms]} critical_section ${critical_section[cs]}"
        echo "tasklets;cycles;normalized_cycles"

        #For each number of tasklets
        for ((tasklets = 2; tasklets <= 16; tasklets += 2))
        do
            #Run the benchmark
            command="bench handshake_kernel ${tasklets} ${numOps} ${critical_section[$cs]} ${main_section[$ms]}"
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

            echo ${tasklets}";"${cycles}";"${normalized} >> ${filename}
            echo ${tasklets}";"${cycles}";"${normalized}
        done
        echo "" >> ${filename}
        echo ""
    done
done