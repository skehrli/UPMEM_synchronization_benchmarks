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

#For each number of dpus
for((dpus = 1; dpus <= 64; dpus*=2))
do
    #For each main_section
    for ((ms = 0; ms < num_main_sections; ms++))
    do
        #For each critical_section
        for ((cs = 0; cs < num_critical_sections; cs++))
        do
            #New title in result file
            echo "main_section ${main_section[ms]} critical_section ${critical_section[cs]}" >> ${filename}
            echo "dpus;tasklets;cycles;normalized_cycles" >> ${filename}

            echo "main_section ${main_section[ms]} critical_section ${critical_section[cs]}"
            echo "dpus;tasklets;cycles;normalized_cycles"

            #For each number of tasklets
            for ((tasklets = 2; tasklets <= 16; tasklets*=2))
            do
                #Run the benchmark
                command="bench handshake_kernel ${tasklets} ${dpus} ${numOps} ${critical_section[$cs]} ${main_section[$ms]}"
                if [ -z ${1+x} ]; 
                then 
                    result=$(LD_LIBRARY_PATH=./upmem-2023.1.0-Linux-x86_64/lib ./bin/${command})
                else 
                    result=$(./bin/${command})
                fi

                #Get cycles
                cycles_str=$(grep 'Maximum Cycles:' <(echo "$result"))
                read -ra split <<<"$cycles_str"

                cycles=${split[2]}
                normalized=${split[6]}

                echo ${dpus}";"${tasklets}";"${cycles}";"${normalized} >> ${filename}
                echo ${dpus}";"${tasklets}";"${cycles}";"${normalized}
            done
            echo "" >> ${filename}
            echo ""
        done
    done
done
