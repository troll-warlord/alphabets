#!/usr/bin/env sh

set -e

npm run build

cd dist

git init
git add -A
git commit -m "Deploying application"
git push -f git@github.com:troll-warlord/alphabets.git master:live