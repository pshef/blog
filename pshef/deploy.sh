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

echo -e "Do you want to use the same commit message? (y/n)"

read ans

if [ "$ans" == y ]
then
# Commit /public changes
	git commit -m "$msg"
else
	echo -e "What is your second commit message?"
	read msg2
	git commit -m "$msg2"

fi

# Push /public changes
git push origin main

# Go back to Project Root
cd ..

echo 
if ["$ans" == y ]
then
	echo -e "You updated the repo with commit message \"$msg\". Thanks!"
else
	echo -e "You updated the repo with commit messages \"$msg\" and \"$msg2\". Thanks!"
