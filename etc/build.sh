#!/usr/bin/env bash

DOCS_REPO=${DOCS_REPO:-"git@github.com:UnoLauncher/UnoLauncher.github.io.git"}
FILES_REPO=${FILES_REPO:-"git@github.com:UnoLauncher/Files.git"}
LEX_DEPLOY=https://github.com/LexBot/Deploy.git
DEPLOY_SCRIPTS=/tmp/unolauncher/deploy
FILES=/tmp/unolauncher/Files

# Get the deploy scripts
git clone $LEX_DEPLOY $DEPLOY_SCRIPTS

# Initialize the ssh-agent so we can use Git later for deploying
eval $(ssh-agent)

# Set up our Git environment
$DEPLOY_SCRIPTS/setup_git

# Clone repo
mkdir public
cd public
git init
git remote add origin $DOCS_REPO
git fetch
git checkout master

# Build the docs
cd ../
hexo generate
cd public

# If we're on the master branch, do deploy
if [[ $TRAVIS_BRANCH = source ]]; then
    # Deploy
    git add --all .
    git commit -q -m "Deploy $(date)"
    git push -q -f origin master
    echo "Done! Successfully published docs!"

    # Copy to Files repo
    git clone $FILES_REPO $FILES
    cp news.json $FILES/launcher/json/news.json
    cd $FILES
    git add --all .
    git commit -q -m "Deploy $(date)"
    git push -q -f
    echo "Done! Successfully published to Files repo!"
fi

# Kill the ssh-agent because we're done with deploying
eval $(ssh-agent -k)

exit 0