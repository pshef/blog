---
title: "A New Script"
date: 2022-05-16T20:14:07-05:00
draft: false
author: Christopher
---
As you may have guessed from my most recent [Logfile dump](https://pshef.work/posts/logfile_dump_week1922/) (and if you went and looked at the commit messages for this blog) you may have noticed that things were going awry. I don't know how it happened, but I'm assuming I screwed something up when I had the DNS problems (that I never figured out how that happened) which resulted in one week's Logfile dump being just fine and then being broken after that point. I won't blame anyone other than myself, but it's not like I touched anything between week 18 and week 19...

But I digress. A friend ([@GrahamHelton3 on twitter](https://twitter.com/GrahamHelton3) suggested I try and automate more of my blog writing process instead of just the updating of the Github repo. So I wrote a script called [autoBlog](https://github.com/pshef/autoBlog), and the git repo will serve as a POC for it. It's nothing magical or earth shattering, but it works for me and how I have my system set up.

Two notes that I want to draw attention to in the script:
1) I have predefined in my dotfile the variable $GITHUB to be the local directory that all of my GitHub repos are cloned to (in my case, it's `~/GitHub_repos`). If you want to try and run this script yourself, you can either set the variable yourself for how your own computer is set up, or you can edit the script so it's a static path. 
2) This script also uses the [deploy](https://raw.githubusercontent.com/pshef/blog/main/pshef/deploy.sh) script that I have saved in my blog repo. While this works for now, because I don't plan on changing that script any time soon, I may end up removing it and incorporating the script directly into this one so there won't be any dependencies for this script to work. While I'm thinking about it, I like the idea of repurposing the deploy script to be one I can use for all my GitHub repos, but I'll have to figure out how to do that at a different time.
