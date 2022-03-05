---
title: "FIDO2 As Login"
date: 2022-03-05T11:49:09-06:00
draft: false
author: Christopher
---

I'm a huge fan of FIDO2.

I use my FIDO2 key on every account I can. I have a stand-alone [FIDO2 USB](https://shop.nitrokey.com/shop/product/nitrokey-fido2-55), I have two of the [Nitrokey 3's](https://shop.nitrokey.com/shop/product/nk3cn-nitrokey-3c-nfc-148) (that will eventually also be able to serve as FIDO2, GPG key storage, limited password manager, etc., but currently only has FIDO2), and a [hardware password manager](https://onlykey.io/) that also has some cool FIDO2 implementation with it. I can't get enough of these things! FIDO2 as my 2nd factor for authentication is tremendously easier than a TOTP in my opinion, as long as you're on a device that can accept FIDO2 input. (That's why I got a NFC FIDO2 key.)

And while I use FIDO2 for pretty much everything, there's one thing that I've wanted to use my Nitrokeys for, and that's for my actual computer.

I've gotten the first steps of this done. There's documentation out there, but when I first got my FIDO2 devices the information was less than clear. Since then, both [Nitrokey](https://docs.nitrokey.com/fido2/linux/desktop-login.html#modify-the-pluggable-authentication-module-pam) and [Yubikey](https://support.yubico.com/hc/en-us/articles/360016649099-Ubuntu-Linux-Login-Guide-U2F) have improved their documentation on the process. Here's what I did, what I learned, the one problem I ran into, and what I'm going to do next with this. **Note: some of this does require root permissions, so you'll want to leave a terminal open that has sudo already authenticated, or just be bold and use `sudo su` and hope you don't mess anything else up.**

### Process

There's no need to reinvent the wheel too much here. If you want to read the good directions, click through the Nitrokey and Yubikey directions I linked to above. All I want to do here is *briefly* put down the steps I took to get FIDO2 on my computer.

1) The first thing I did was *create a backup user*. Give it a good password, and just leave it there. If you screw something up to where you can't log back into your account or `sudo` to change a file, you'll need this account to fix it. I did it through my Pop_os GUI: `Settings` > `Users` > `Unlock` > `Add User...`. You can do it through the CLI too if you want.

2) Next you need to import `rules` so that FIDO2 can be recognized. Because I'm using my Nitrokey, I used their ruleset:

```
$ cd /etc/udev/rules.d/
$ sudo wget https://raw.githubusercontent.com/Nitrokey/libnitrokey/master/data/41-nitrokey.rules
$ sudo systemctl restart udev
```

3) Make sure libpam-u2f is installed 
```
$ sudo apt update && sudo apt install libpam-u2f
```

4) Make a directory to generate the key in. (Because I have a Nitrokey 2 already, this was already created.)
```
$ mkdir ~/.config/Nitrokey
```

5) To generate the U2F config file and then move it to a location that will require root to edit (I picked `/etc` as an example, but you can put it anywhere), run the command: 
```
$ pamu2fcfg > ~/.config/Nitrokey/u2f_keys 
$ sudo mv ~/.config/Nitrokey /etc
```

6) The "module string" that will be used to edit the files will be:
```
auth <control flag> pam_u2f.so authfile=/path/to/u2f_keys
```
(Where `/path/to/u2f_keys` is wherever you moved the file in step 5.)

Now you have two options: you can either edit `/etc/pam.d/common-auth` by placing this module string at either the beginning or the end, and this will now require your FIDO2 key for any authentication that utilizes `@include common-auth` in it; or you can edit `/etc/pam.d/sudo`, `/etc/pam.d/gdm-password`, and `/etc/pam.d/login` individually and insert the module string after the `@include common-auth` line. The first choice will be a catch-all for these authentication processes, whereas the second choice will allow you to pick and choose which process you want the 2nd factor to be required for, for example if you want to require FIDO2 to log into your account but don't care if you need it for using sudo.

In the module string that I have right now, I used the control flag of `sufficient` for reasons I'll get to in a moment, and I highly recommend you use `sufficient` to start off with until you know everything is working correctly. You can also add flags that will have your computer prompt you to touch your FIDO2 device. Mine in use looks like:
```
auth sufficient pam_u2f.so authfile=/path/to/u2f_keys cue prompt
```
I have this using the second options above, including it in `sudo`, `gdm-password`, and `login`. 

If you end up choosing path 1, [Pop_os](https://support.system76.com/articles/yubikey-login/) says you should add  your modification to the beginning of `common-auth`. (This module string is different from what Pop_os has, and that's because they're using a Yubikey, which has its own libraries and shit.) Nitrokey just says to "add" it. In my testing, the only difference is if you're prompted to touch your FIDO2 before or after your password. If you put it at the top, you have to press the FIDO2 before entering your password; if you put it at the bottom, you input your password first. (Note: if your FIDO2 device isn't plugged in when you input your password and you're using the `required` or `requisite` control flags, it'll just keep telling you you've used the wrong password as opposed to telling you to input your FIDO2 key. In this case if your module string is at the top, you'll just automatically get told you can't login and receive three failed login attempts; if it's at the bottom, you have to keep inputting your password until you use up your tries or plug in your key. Personal preference here.)

BUT WAIT! Hopefully you didn't just type in what I told you to without reading ahead. Before you save things and close out, and potentially screwing yourself over and locking yourself out of your account if you typed something wrong, go ahead and open up a second terminal and try `sudo echo test`. If you configured everything right, you should be prompted for both your password and your FIDO2 device. If you messed up somewhere, at least you're still able to edit the files in your other terminal (since you need to be root to edit anything in `/etc/pam.d`). If you closed out your root terminal and you messed something up, well, that's why I told you to make that backup user.

At this point you're technically done, but you can play around with things (like different control flags) if you want. Feel free to set yours to `required` if you want. I tried it and it works fine. Trust me. (But it's not my fault if something breaks!)

I have noticed that with how I have everything set up, when I restart my computer I'm asked to unlock my keyring even after logging into my account. It's only once, so not really a big deal.

### Problems

There's one problem I ran into, and one kind-of-a-problem-but-not-really problem. The actual problem, that I haven't investigated yet, is that I'm unable to add backup FIDO2 keys. All of the documentation says to use:
```
$ pamu2fcfg -n >> /path/to/u2f_keys
```
However, when I do this I'm prompted to input a PIN for `/dev/hidraw1`. Nitorkey FIDO2 devices don't allow for PINs, so I'm unable to add a backup FIDO2 device at the moment. A super quick Google search was not fruitful but I'm sure it's out there.

Every time I tried this, it also overwrote my u2f_keys file even when I used a test file. Not sure why.

Because of this, my kind-of problem is simply that none of my other FIDO2 devices are standalone FIDO2 devices. I don't know if this plays a role in being able to add a backup or not, but when I tried leaving in my standalone Nitrokey FIDO2 and then running the above command to add the FIDO2 from my Nitrokey 3, it didn't even register that I tried to use the Nitrokey 3. I also tried to use `pamu2fcfg -n > /path/to/completely/different/file` that I was going to just append to my `u2f_keys` file but I still get the prompt for the `hidraw1` PIN.

### Next Steps

The first thing I need to do now is figure out what's going on with the PIN issue. I need to have a surefire way to have a backup FIDO2 device configured so I'm not S.O.L. if something happens. Once I get this done, I'm going to require FIDO2 for logging into the user account, but have it be a single authentication factor for sudo.

At this point, that's all I really am interested in doing for FIDO2 at the moment. I've wanted to get my Nitrokey 2 to serve as my LUKS encryption key for a while now and want to tackle that at some point, but I decided to wait until all the firmware is updated for Nitrokey 3 and I'll just use that instead.
