#! /bin/bash

echo -e "Deploying updates to GitHub..."

# Build project
hugo -t eureka

# Add commit message
msg="rebuilding site `date`"
if [$# -eq 1]
	then msg="$1"
fi

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
