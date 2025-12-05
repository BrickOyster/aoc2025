#!/bin/bash
# aocli view -d 3 -y 2025
time {
total=$(wc -l < 3.in)
count=0
bar_width=50
part1=0; part2=0
part1length=2; part2length=12

while IFS= read -r i; do
    ((count++))

    progress=$((count * bar_width / total))
    bar=$(printf "%${progress}s" | tr ' ' '#')
    space=$(printf "%$((bar_width - progress))s")

    printf "\r[%s%s] %d/%d" "$bar" "$space" "$count" "$total"
    gotpart1=false
    nchoise=111111111111
    while :; do
        choise=$(echo $nchoise | sed 's/.\{1\}/&\n/g' | head -n 1)
        largest=$(echo $i | sed 's/.\{1\}/&\n/g' | sort -nur | head -n $choise | tail -n 1)
        next_largest=$largest
        sub_i=$i
        for n in {2..12}; do
            next_choise=$(echo $nchoise | sed 's/.\{1\}/&\n/g' | head -n $n | tail -n 1)
            sub_i=$(echo ${sub_i#*$next_largest})
            next_largest=$(echo $sub_i | sed 's/.\{1\}/&\n/g' | sort -nur | head -n $next_choise | tail -n 1)
            if [[ -z $next_largest ]]; then 
                carry=1
                pos=$((n-1))
                while (( carry == 1 && pos >= 0 )); do
                    digit=${nchoise:$pos:1}
                    digit=$((digit + 1))
                    if [[ $digit == 10 ]]; then
                        digit=1
                        carry=1
                    else 
                        carry=0
                    fi
                    prefix=${nchoise:0:$pos}
                    suffix=${nchoise:$((pos+1))}
                    nchoise="${prefix}${digit}${suffix}"    
                    ((pos--))
                done
                break
            fi
            largest=$largest$next_largest
            if [[ $gotpart1 == false ]]; then
                (( part1 += $largest))
                gotpart1=true
            fi
        done
        if [[ ${#largest} -eq $part2length ]]; then break; fi
    done
    ((part2 += $largest))
done < 3.in; echo ""

echo "Part 1: $part1"
# aocli submit -d 3 -y 2025 -p 1 17432
echo "Part 2: $part2"
# aocli submit -d 3 -y 2025 -p 2 173065202451341
}
echo "Done!"
