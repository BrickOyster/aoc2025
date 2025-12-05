cd ..
if [[ -z $(git submodule update --remote ./brick/) ]]; then
    echo "No updates in brick"
    exit 0
fi
git add brick
cd brick
message=$(git log --format=%B -n 1 HEAD)
cd ..
git commit -m "$message"
git push
