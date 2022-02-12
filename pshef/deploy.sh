#! /bin/bash

# build project
hugo -t eureka

# Add changes to root git
git add .

# Add root commit message
echo -e "What is your commit message?"
read msg_blog
echo -e "Deploying updates to GitHub with commit message \"$msg_blog\"."

# Commit changes to root git
git commit -m "$msg_blog"

# Push root changes
git push origin main

# /public repo update
echo
echo -e "Do you want to update the blog? (y/n)"
read public_update

if [ "$public_update" == y ]
then
	# Change to public folder
	cd public
	
	# Add /public changes
	git add .

	# Add /public message
	echo	
	echo -e "Do you want to use the same commit message? (y/n)"
	read public_ans

	if [ "$public_ans" == n ]
	then
		# Add /public commit message
		echo
		echo -e "What is your /public commit message?"
		read msg_public

		# Commit changes to /public
		git commit -m "$msg_public"

		# Push /public changes
		git push origin main

		# Echo finishing message 1
		echo
		echo
		echo -e "You updated your repos with commit messages \"$msg_blog\" and \"$msg_public\". Thanks!"
	else "$public_ans" == y ]
		# Echo finishing message 2
		echo
		echo
		echo -e "You updated your repos with commit message \"$msg_blog\". Thanks!"
	fi
elif [ "$public_update" == n ]
	# Echo finishing message 3
	echo
	echo
	echo -e "You updated your repo with commit message \"$msg_blog\". Thanks!"
fi
