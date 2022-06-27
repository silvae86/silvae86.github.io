---
layout: post
title:  "OWC Thunderbay 4 Mini review: 20TB, RAID, Thunderbolt 3 for less than €800"
date: 2022-06-26 16:20:000 +0100
tags: mac storage owc thunderbay thunderbolt harddrive shucking seagate hardware review
published: true
---

{% include image.html src="/assets/images/post-images/2022-06-27-thunderbay-mini-4-review-10TB/IMG_0129.jpeg"
caption="The Thunderbay 4 Mini Packaging" imageposition="center"
title="Thunderbay 4 Packaging"
%}

The OWC Thunderbay 4 Mini is a pretty unique value proposition due to its dimensions and flexibility. It sports a tiny footprint, fitting perfectly in a minimalistic desktop, and achieves it by using 2.5'' hard drives instead of 3.5''.  

Despite being quite expensive for an enclosure at around €350, its Thunderbolt 4 interface  When combined with some hard drive shucking it can become an attractive proposal from a cost/benefit perspective.

## Design and dimensions

{% include image.html src="/assets/images/post-images/2022-06-27-thunderbay-mini-4-review-10TB/IMG_0130.jpeg"
caption="Thunderbay 4 Mini Design. Notice the power brick on the side as a size comparison." imageposition="center"
title="Thunderbay 4 Mini Design. It's really tiny."
%}

## SoftRAID as a value proposition

The enclosure includes a license of OWC's software RAID solution, [SoftRAID XT](https://www.softraid.com/). After some investigation, and even though I paid for the software as a part of the bundle, I decided against using it even before I bought the unit. Instead, I had already opted for Apple's built-in software RAID instead. Here are the pros and cons of SoftRAID: 

### ✅ Pros

1. Windows + Mac compatibility. You can use your drives on both operating systems, provided SoftRAID is installed.
2. Nice UI that is easy to use for everyone
3. Drive status monitoring + alerts


### ❌ Cons

1. (Absolute deal breaker to me) Should you opt for using SoftRAID, you are stuck with it forever. All data in the Thunderbay will only be readable and writeable with the software installed. It works as a macOS Kernel Extension, meaning that it is flaky as they come, and it working or not will depend on Apple's whim. Should Apple decide to implement changes to the OS that break SoftRAID's Kernel Extension, you are left stuck on an older operating system while you wait for OWC to update the software, if at all possible. This has happened before [happened](https://discussions.apple.com/thread/252455756) [when Apple released macOS Big Sur](https://developer.apple.com/forums/thread/666915?page=3). For Catalina it was even worse, with similar issues and a [nasty fix provided at the time](https://eshop.macsales.com/blog/64201-secure-boot-and-sip-guard-your-mac/) requiring you to disable System Integrity Protection. At least OWC seem to be committed to good customer service, providing not only a [list of known issues](https://www.softraid.com/support/known-issues/) with SoftRAID, but also continuing to support the software. Long story short, I worry about using such software to keep valuable data, even if OWC are not to blame. 
2. The SoftRAID license is single-machine only, meaning that if you own several Macs and need to alternate your Thunderbay between more than one machine, you have to deactivate SoftRAID on the first and activate it on the second machine. Every. Single. Time. Not for me, sorry.
3. I am not interested in [RAID 5](https://en.wikipedia.org/wiki/Standard_RAID_levels#RAID_5) (offered by SoftRAID but not by Apple's Disk Configurator). When compared to RAID 5, RAID 10 offers you more usable storage, but its working principle seem less robust to me. Requiring a minimum of _N_ hard drives, RAID 5 reserves, 1/_N_ of the storage of each drive for parity information. More importantly, it allows a single drive to fail. The problems come when a single drive **does fail**, since the volume rebuild process can take a long time and will put high strain on all the remaining drives. As a rule of thumb, if you have a drive fail, it is reasonable to assume that at least one of the others could be close to failure. Stressing them all for [tens of hours](https://serverfault.com/questions/967930/raid-5-6-rebuild-time-calculation) to [rebuild the volume through SoftRAID](https://macperformanceguide.com/blog/2019/20190216_2035-rebuilding-SoftRAID-RAID5.html) does not seem healthy, since if any of the other drives fail, you lose all data in all the drives.
4. You need SoftRAID to rebuild the volumes. Using Apple's software RAID, you can use the command line or the Disk Utility. I like command-line stuff because although ugly, you know it's going to work and comes OOB with every single Mac for years to come.



## Shucking 2.5'' hard drives for the RAID array

Hard drive [_shucking_](https://en.wikipedia.org/wiki/Disk_enclosure#Hard_drive_shucking) is the process of buying an external (USB) hard drive and cracking open the enclosure to extract the hard drive inside and use it as an internal hard drive. The main advantage is a much lesser cost per drive (internals are approximately 37% more expensive for the same capacity in my particular case) and you get a free enclosure + USB 3 cable. This can be useful for when you finally decide to retire the drives from active use by putting them back in their case. 

A very important aspect to take into consideration is that 2.5'' drives used in external hard drives are 15mm thick, so they will not fit into a laptop, for example. However, they are perfect for the Thunderbay Mini, since the enclosure supports hard drives up to 15mm thick. I initially found this detail in the Thunderbay 4 Mini with Thunderbolt 2 [manual](https://www.owcdigital.com/assets/products/thunderbay-4-mini-thunderbolt-2/thunderbay-4-mini-tb2-user-guide.pdf), and it remains the same for the newer TB3 model.

Drives that can be shucked are rarer and rarer though; you need to do some research before buying your drives.

## Selecting a shuckable hard drive

Manufacturers are wise to the fact that people shuck their drives. Practically all external drives in the market are now built with a direct connection between the USB port and the hard drive controller, without a SATA port in between. Western Digital and Toshiba now adopt such a practice, with a notable exception being Seagate. Many Seagate drives still sport a USB-to-SATA adapter board that you can detach, converting the drive back to its 'internal' form.

I chose the Seagate Basic Portable 5TB external hard drive (STJL5000400), which inside holds a standard Seagate Barracuda hard drive at 5400rpm. No fancy finishing, simple plastic case (easy to crack open) and, most importantly, uses a SATA-to-USB3 adapter board. I bought 5 of them to have one in reserve, while 4 are in use inside the Thunderbay. While RAID does not require identical disks, I like to have them. It is better to buy them now than be looking for one some years down the road when one drive fails.

## Shucking the Seagate 5TB Basic Portable

{% include image.html src="/assets/images/post-images/2022-06-27-thunderbay-mini-4-review-10TB/IMG_0119.jpeg"
caption="Seagate Basic Portable 5TB external drives" imageposition="center"
title="Seagate 5TB Drives that I will be cracking open"
%}

{% include image.html src="/assets/images/post-images/2022-06-27-thunderbay-mini-4-review-10TB/IMG_0120.jpeg"
caption="Stick a spudger in the edge to crack open the enclosure" imageposition="center"
title="Spudger used to open the case"
%}

{% include image.html src="/assets/images/post-images/2022-06-27-thunderbay-mini-4-review-10TB/IMG_0121.jpeg"
caption="Enclosure open" imageposition="center"
title="Enclosure open"
%}


{% include image.html src="/assets/images/post-images/2022-06-27-thunderbay-mini-4-review-10TB/IMG_0123.jpeg"
caption="Hard drive revealed" imageposition="center"
title="Hard drive revealed"
%}

{% include image.html src="/assets/images/post-images/2022-06-27-thunderbay-mini-4-review-10TB/IMG_0124.jpeg"
caption="Hard drive model and part number" imageposition="center"
title="Hard drive model and part number"
%}

{% include image.html src="/assets/images/post-images/2022-06-27-thunderbay-mini-4-review-10TB/IMG_0125.jpeg"
caption="Peeling off the sticker" imageposition="center"
title="Peeling off the sticker"
%}

{% include image.html src="/assets/images/post-images/2022-06-27-thunderbay-mini-4-review-10TB/IMG_0126.jpeg"
caption="Removing SATA to USB3 adapter board" imageposition="center"
title="Removing SATA to USB3 adapter board"
%}

{% include image.html src="/assets/images/post-images/2022-06-27-thunderbay-mini-4-review-10TB/IMG_0128.jpeg"
caption="Removing anti-vibration feet" imageposition="center"
title="Removing anti-vibration feet"
%}

## Assembling the hard drives inside the Thunderbay enclosure

{% include image.html src="/assets/images/post-images/2022-06-27-thunderbay-mini-4-review-10TB/IMG_0131.jpeg"
caption="Open up the Thunderbay to expose the 4 hard drive trays..." imageposition="center"
title="Opening the Thunderbay"
%}

{% include image.html src="/assets/images/post-images/2022-06-27-thunderbay-mini-4-review-10TB/IMG_0138.jpeg"
caption="Attach a sliding tray to the drive using the 4 screws already on the drive" imageposition="center"
title="Attach sliding tray to the drive"
%}

{% include image.html src="/assets/images/post-images/2022-06-27-thunderbay-mini-4-review-10TB/IMG_0135.jpeg"
caption="Slide the drive into the slot" imageposition="center"
title="Slide the drive into the slot"
%}

{% include image.html src="/assets/images/post-images/2022-06-27-thunderbay-mini-4-review-10TB/IMG_0141.jpeg"
caption="Repeat for all 4 drives" imageposition="center"
title="Repeat for all 4 drives"
%}

{% include image.html src="/assets/images/post-images/2022-06-27-thunderbay-mini-4-review-10TB/IMG_0144.jpeg"
caption="Connect and start up the drive. All status LEDs should light up" imageposition="center"
title="Connect and start up the drive. All status LEDs should light up"
%}

## Choosing between RAID 1+0 or 0+1

## Performance

With this configuration (RAID 10) I got these numbers in BlackMagic Disk Speed Test. Not anywhere near SSD levels, but more than enough for regular media backup. However, it is good to know that I can upgrade to SSDs in the future if I ever need it and prices allow, as the Thunderbolt connection will always allow me to take advantage of their speed.

![BlackMagic Disk Speed Test](/assets/images/post-images/2022-06-27-thunderbay-mini-4-review-10TB/blackmagic.png)

