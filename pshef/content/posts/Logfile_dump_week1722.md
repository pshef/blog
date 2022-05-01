---
title: "Logfile_dump Week 17/22"
date: 2022-05-01T13:31:28-05:00
draft: false
author: Christopher
---
Well the ink has dried, so I guess I can share the good news that I mentioned last week. I accepted a job offer for my first infosec job as an Information Security Analyst! It's an internal transfer with the company I already work for which really helped get my foot in the door. There's no official start date yet as it needs to get worked out between the higher ups, but it's definitely happening.

Because of this, I have spent the last week setting up my work-from-home office and finishing the last ethernet cable runs. While I still have some tidying up to do, everything is more or less set up how it will stay. I should be receiving my new keyboard within the next couple of weeks and that will be all of the hardware that I own left to be sent to me. 

Aside from the good news, I did have a very frustrating time with my wireless routers. My ISP requires that we use their gateway, so I had it in IP Passthrough mode which connected directly into a GL-inet router that was meshed with another one on the other side of the living area. However, especially with the more recent firmware update (from last year) the connection became absolutely h o r r i b l e. Even when I would be connected via ethernet I would regularly have dropped connections, and wifi was even worse. After spending a few months trying to troubleshoot the issue, I finally gave up and took them out of the network. So far the ISP hardware hasn't been horrible, but they don't allow me to change the DNS server which means my Pi Hole is not going to be used network-wide. I found that if I turn off DHCP on the gateway and turn DHCP on on the Pi Hole that devices would pick up the new DNS, but then our phones had a problem staying connected. Ultimately, I'll end up having to manually configure devices to use my Pi Hole for DNS when I set up static IP addresses for things. Not thrilled.

Eventually, I will try a more reputable wireless router and see if I have the same issues, but that will be a ways off.
