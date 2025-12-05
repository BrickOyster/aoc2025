#!/bin/bash
aocli health 2>&1

function getPuzzle {
  DAY=$1
  mkdir -p ./$DAY
  aocli get -o ./$DAY/$DAY.in -d $DAY -y 2025
  bash -c "cat > ./$DAY/$DAY.sh" <<EOF
#!/bin/bash
# aocli view -d $DAY -y 2025
time {
total=\$(wc -l < $DAY.in)
count=0
bar_width=20
part1=0; part2=0

while IFS= read -r i; do
    ((count++))

    progress=\$((count * bar_width / total))
    bar=\$(printf "%\${progress}s" | tr ' ' '#')
    space=\$(printf "%\$((bar_width - progress))s")

    printf "\r[%s%s] %d/%d" "\$bar" "\$space" "\$count" "\$total"
done < $DAY.in; echo ""

echo "Part 1: \$part1"
# aocli submit -d $DAY -y 2025 -p 1
echo "Part 2: \$part2"
# aocli submit -d $DAY -y 2025 -p 2
}
echo "Done!"
EOF
  aocli view -d $DAY -y 2025
}

function usage { echo "Usage: $0 [-p <1-25>] [-s]" 1>&2; exit 1; }

while getopts "h?p:s" opt; do
  case "${opt}" in
    h|\?) echo "Usage: $0 [-p <DAY>] [-l]" >&2 ;;
    p) echo "Getting Day $OPTARG puzzle..."; getPuzzle "$OPTARG" ;;
    s) echo $(cat .session_cookie) > ~/.config/aocgo/session.token; aocli health 2>&1; aocli;;
  esac
done
