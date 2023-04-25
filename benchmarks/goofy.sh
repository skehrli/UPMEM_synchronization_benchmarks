for((tasklet=1; tasklet<=24; tasklet *= 2))
do
    echo ${tasklet}
    if [ "$tasklet" -eq 16 ];
    then
        tasklet=12
    fi
done
