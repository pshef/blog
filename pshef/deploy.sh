#! /bin/bash

echo -e "Deploying updates to GitHub..."

# Build project
hugo -t eureka

# Add changes to git
git add .

msg="rebuilding site 'date'"
if [ $# -eq 1 ]
	then msg="$1"
fi

git commit -m "$msg"

git push origin main

# Changing to Public Folder

cd public

# Adding Public changes to git
git add .

msg="rebuilding site 'date'"
if [ $# -eq 1]
	then msg="$1"
fi

git commit -m "$msg"

git push origin main

# Go back to Project Root
cd ..
