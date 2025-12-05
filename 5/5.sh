#!/bin/bash
# aocli view -d 5 -y 2025
time {
ranges=$(sed -e '/^$/,$d' < 5.in)
ingredients=$(sed -e '1,/^$/d' < 5.in)
total=$(echo $ingredients | wc -w)
count=0
bar_width=20
part1=0; part2=0

echo "Processing Part 1..."
# for i in $ingredients; do
#     ((count++))

#     progress=$((count * bar_width / total))
#     bar=$(printf "%${progress}s" | tr ' ' '#')
#     space=$(printf "%$((bar_width - progress))s")

#     printf "\r[%s%s] %d/%d" "$bar" "$space" "$count" "$total"
#     for r in $ranges; do
#         IFS='-' read -r min max <<< "$r"
#         if (( $i >= $min && $i <= $max )); then
#             (( part1 += 1 ))
#             break
#         fi
#     done
# done; echo ""

echo "Part 1: $part1"
# aocli submit -d 5 -y 2025 -p 1 770
starts=()
ends=()
for r in $ranges; do
    IFS='-' read -r s e <<< "$r"
    starts+=("$s")
    ends+=("$e")
done

total=$(( $(echo $ranges | wc -w) ))
count=1
# Sort ranges by start
for ((i=0; i<$total-1; i++)); do
    ((count++))

    progress=$((count * bar_width / total))
    bar=$(printf "%${progress}s" | tr ' ' '#')
    space=$(printf "%$((bar_width - progress))s")

    printf "\r[%s%s] Sorting..." "$bar" "$space"
    for ((j=i+1; j<$total; j++)); do
        if (( starts[j] < starts[i] )); then
            # swap start
            tmp=${starts[i]}
            starts[i]=${starts[j]}
            starts[j]=$tmp

            # swap end
            tmp=${ends[i]}
            ends[i]=${ends[j]}
            ends[j]=$tmp
        fi
    done
done; echo ""

count=0
merged=()
cur_s=${starts[0]}
cur_e=${ends[0]}

for ((i=1; i<$total; i++)); do
    ((count++))

    progress=$((count * bar_width / total))
    bar=$(printf "%${progress}s" | tr ' ' '#')
    space=$(printf "%$((bar_width - progress))s")

    printf "\r[%s%s] Merging..." "$bar" "$space"
    s=${starts[i]}
    e=${ends[i]}

    if (( s <= cur_e + 1 )); then
        # overlap / adjacent → extend
        (( e > cur_e )) && cur_e=$e
    else
        # no overlap → save previous range
        merged+=("$cur_s-$cur_e")
        cur_s=$s
        cur_e=$e
    fi
done; echo ""
merged+=("$cur_s-$cur_e")

for r in "${merged[@]}"; do
    echo "Processing range $r..."
    IFS='-' read -r min max <<< "$r"
    part2=$(( part2 + max - min + 1 ))
done

echo "Part 2: $part2"
# aocli submit -d 5 -y 2025 -p 2 357674099117260
}
echo "Done!"
