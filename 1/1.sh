#!/bin/bash
# aocli view -d 1 -y 2025
time {
curr=50; part1=0; part2=0

while IFS= read -r i; do
    dir="${i%%[0-9]*}"
    num="${i#"$dir"}"
    if [[ $dir == "L" ]]; then
        while [[ $num -gt 0 ]]; do
            curr=$(( $curr + 99 ))
            curr=$(( $curr % 100 ))
            num=$(( $num - 1 ))
            if [[ $curr -eq 0 ]]; then part2=$(($part2 + 1)); fi
        done
    elif [[ $dir == "R" ]]; then
        while [[ $num -gt 0 ]]; do
            curr=$(( $curr + 1 ))
            curr=$(( $curr % 100 ))
            num=$(( $num - 1 ))
            if [[ $curr -eq 0 ]]; then part2=$(($part2 + 1)); fi
        done
    fi
    if [[ $curr -eq 0 ]]; then part1=$((($part1) + 1 )); fi
done < 1.in

echo "Part 1: $part1"
# aocli submit -d 1 -y 2025 -p 1 962
echo "Part 2: $part2"
# aocli submit -d 1 -y 2025 -p 2 5782
}
echo "Done!"