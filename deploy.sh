#!/usr/bin/env sh

set -e

npm run build

cd dist

git init
git remote add origin https://github.com/troll-warlord/alphabets.git
git config user.name "${GIT_USER_NAME}"
git config user.email "${GIT_USER_EMAIL}"

git add -A
git commit -m "Deploying application"

git push -f origin master:live