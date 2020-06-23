#!/bin/bash

set -ex

cd "$(dirname "$0")"
cd ..


GIT_REMOTE=$(git config remote.origin.url)
GIT_USER_NAME='Deploy Robot'
GIT_USER_EMAIL='santhosh.piduri@gmail.com'

## Build the project into the "out" directory
rm -rf ./out
timeout 60 ./node_modules/.bin/next build
./node_modules/.bin/next export

touch ./out/.nojekyll
cp .gitignore ./out/.gitignore
mkdir ./out/.circleci && cp .circleci/config.yml ./out/.circleci/config.yml

# make a directory to put the gh-pages branch
mkdir gh-pages-branch
cd gh-pages-branch
git init
git remote add --fetch origin "$GIT_REMOTE"

# switch into the the gh-pages branch
if git rev-parse --verify origin/gh-pages > /dev/null 2>&1
then
    git checkout gh-pages
    git rm -rf .
else
    git checkout --orphan gh-pages
fi

# copy over the built site
cp -a ../out/. .

git add -A
git -c user.name="$GIT_USER_NAME" -c user.email="$GIT_USER_EMAIL" commit --allow-empty -m "deploy static site @ $(date)"
git push --force origin gh-pages
cd ..
rm -rf gh-pages-branch

echo "Depolyment Complete"
