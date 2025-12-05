#!/bin/bash
# aocli view -d 2 -y 2025
time {
part1=0; part2=0

while IFS= read -r i; do
    start=${i%-*}
    end=${i#*-}
    for num in $(seq $start $end); do
        if [[ $(echo $num | grep -E '^([0-9]+)\1+$') ]]; then
            (( part2 += $num ))
            if [[ $(echo $num | grep -E '^([0-9]+)\1$') ]]; then
                (( part1 += $num ))
            fi
        fi
    done
done < <(tr ',' '\n' < 2.in)

echo "Part 1: $part1"
# aocli submit -d 2 -y 2025 -p 1 26255179562
echo "Part 2: $part2"
# aocli submit -d 2 -y 2025 -p 2 31680313976
}
echo "Done!"