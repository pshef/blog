---
title: "Logfile_dump Week 19/22
date: 2022-05-15T17:17:49-05:00
draft: false
author: Christopher
---
With the exception of a chair, my office is completely set up now. My [Moonlander](https://www.zsa.io/moonlander/) keyboard is in and I've been practicing using it how they recommend (laid flat and without chaning the key layout) and while my typing has slowed down somewhat, I'm getting the hang of it. WIth regular typing I'm pretty close to how I had been with a regular keyboard, but when it comes to using special characters or the "number pad" it still takes a lot of time. I keep the interactive layout up so I can see what everything is which certainly helps!

With the help of a friend, I was able to set up my first VLAN through my "smart" switches. The switch defaults to everything being on VLAN1, and I wanted to take a single port and put it on VLAN2; the problem I ran into was when I removed the port from VLAN1 and moved it to VLAN2, that port no longer got network connection and couldn't even see the router. Unbeknownst to me, I needed to keep every port in VLAN1, and then I could have specific ports *also* be in other VLANs. After I added the one port back into VLAN1 and VLAN2, the issue went away. Now I have the network connection and it's not visible to the rest of my network! The reason I did this is two-fold: first, just so I could learn how to do it; second, I want to keep traffic from my computers separate from that of everything else. Mission accomplished on both fronts. 

This week is the Antisyphon [Getting Started in Security](https://www.antisyphontraining.com/getting-started-in-security-with-bhis-and-mitre-attck-w-john-strand/) course, but I won't be able to attend this one live; because I'm not fully transferred over to my new position yet, my "interim manager" (as he likes to call himself) doesn't allow time for me to take training classes on the clock. I'll be able to watch it after the fact which will still be useful, but there's always something special about attending the course live.

Along those lines, I'm hoping to attend my first Pentester Academy [Beginner's Active Directory bootcamp](https://bootcamps.pentesteracademy.com/course/ad-beginner-jun-22) next month. Some of my coworkers have mentioned possibly attending so I think it will help with both my education and my relationship with my coworkers.
