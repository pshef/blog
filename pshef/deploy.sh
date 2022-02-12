#! /bin/bash

# Build project
hugo -t eureka

echo -e "What is your commit message?"

# Add commit message
read msg

echo -e "Deployting updates to GitHub with commit message $msg"

# Add changes to root git
git add .

# Commit root changes
git commit -m "$msg"

# Push root changes
git push origin main

# Changing to Public Folder
cd public

# Adding /public changes
git add .

# Commit /public changes
git commit -m "$msg"

# Push /public changes
git push origin main

# Go back to Project Root
cd ..

clear

echo -e "You updated the repo with commit message $msg. Thanks!"
