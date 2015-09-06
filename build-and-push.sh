#!/bin/bash
GIT_BRANCH=`git branch | sed -n '/\* /s///p'`

# Remove lib & dist from gitignore
sed -i '' '/lib/d' ./.gitignore
sed -i '' '/utils/d' ./.gitignore

# build the project & add the dist files to the previous commit
npm run build
git add .
git commit --amend --no-edit

# Token stored in environment variable in circle.yml
git remote add dist https://altdeployer:$GH_TOKEN@github.com/mull/test.git
git push dist $GIT_BRANCH:$GIT_BRANCH -f
