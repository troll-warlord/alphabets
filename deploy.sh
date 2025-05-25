#!/usr/bin/env sh

set -e

npm run build

cd dist

git init
git add -A
git commit -m "Deploying application"
git remote add origin https://github.com/troll-warlord/alphabets.git

git push --force-with-lease origin master:live