#! /bin/bash

COUNTER=0
ITERATIONS=0
BATCH=10

while IFS=$"\n" read -r p || [ -n "$p" ]
do
    if [[ "$p" != "GO" ]]; then
        if [[ $COUNTER == 0 ]]; then
            if [[ $ITERATIONS != 0 ]]; then
                printf ';\nGO\n'
            fi
            printf '%s\n' "$p"
            let "ITERATIONS+=1"
        else
            p=${p#*VALUES }
            p=${p%;}
            printf '%s\n' "$p"
        fi
        let "COUNTER=(COUNTER+1)%$BATCH"
    fi
done
if [[ $ITERATIONS != 0 ]]; then
    printf ';\nGO\n'
fi
