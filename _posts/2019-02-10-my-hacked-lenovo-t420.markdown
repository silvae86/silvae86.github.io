---
layout: post
title:  "The story of my highly upgraded Lenovo T420"
date:   2019-02-10 09:01:000 +0100
tags: hardware hack t420 lenovo upgrade 2960XM intel
redirect_from:
  - "/hardware/hacks/t420/toaster/2019/02/10/my-hacked-lenovo-t420/"
---


I have a Lenovo T420 that I love because of its unmatched 8-row keyboard. It is old and was slow with its original i5-2520m cpu... but it is very Linux friendly and runs MacOS too. A GitHub user called tluck has compiled [everything you need](https://github.com/tluck/Lenovo-T420-Clover) to get it running under MacOS (yes, even Catalina, an OS that no mac from 2011 supports...).

![Hacked Lenovo T420](/assets/images/post-images/2019-02-10-my-hacked-lenovo-t420/IMG_2361.jpg){:class="img-center"}
*My Upgraded Lenovo T420*{:class="img-caption"}

It was sad to see Apple dropping support of such (still to this day) useful machines. Perhaps they want us to forget yet another [screw-up](https://discussions.apple.com/thread/4659905) with the AMD 6750m and AMD 6770m GPUs?


![Traditional Blue Enter Key](/assets/images/post-images/2019-02-10-my-hacked-lenovo-t420/IMG_2362.jpg){:class="img-center"}
*Close-up of the traditional Blue Enter Key*{:class="img-caption"}

And yes, I was the owner of one of the ill-fated 8600GT-equipped [A1260 MacBook Pros](https://www.ifixit.com/Answers/View/431333/MacBook+Pro+A1260+-+Logic+Board+Repair+-+No+Power+Up from 2008) which suffered from the infamous [manufacturing defect](https://forums.lenovo.com/t5/ThinkPad-T61-and-prior-T-series/T61p-Nvidia-problems/td-p/917335) which also claimed the souls of thousands of innocent Thinkpad T61p's (I also have one of those btw...dead and waiting for a donor board!).

## Specs

So far, this machine was upgraded with the following goodies:

- [Hacked BIOS](https://www.bios-mods.com/forum/Thread-REQUEST-Lenovo-Thinkpad-T420-83ETxxWW-Whitelist-Removal?page=31) to enable 1600Mhz DDR3 and Wifi Card Whitelist.
- [2x8gb GSkill Ripjaws 1600Mhz](https://www.gskill.com/product/2/159/1537259792/F3-1600C9D-16GRSLRipjaws-DDR3-SO-DIMMDDR3L-1600MHz-CL9-9-9-1.35V16GB-(2x8GB)) sticks
- 2x 500GB Samsung Evo 860 SSDs in RAID 0 in caddy.
- 1x 250GB mSata SSD Samsung Evo 860.
- 9-cell battery for impressive 2:30hrs of battery life (lol).
- [AzureWave AW-CB160](https://www.ebay.co.uk/itm/BroadCom-AW-CB160-BCM94360HMB-WIFI-HALF-PCI-E-Wireless-BT-Card-BT4-0-WLAN-W003-/303426968043) 3-antenna 1300Mbps wifi card.
- Cooler from the nVidia-GPU equipped version for an impressive extra 5W of cooling performance.
- [GMYLE ExpressCard add on](https://www.amazon.com/ExpressCard-34mm-Adapter-Dual-Port/dp/B0045BLP1S) with 2 USB 3.0 ports (yay, 100MB/s!!).
- Monitor panel from an [Alienware M14X laptop](https://www.youtube.com/watch?v=9h0n-PQNEFw) (one of the rarest and best you can get at 1600x900, which is not to say much, as they are still nasty TN panels).
- Some German keyboard because I like the tactile experience more than the Portuguese ones (there were [3 different manufacturers of keyboard for this machine](http://forum.notebookreview.com/threads/thinkpad-keyboard-identification.634208/))
- Custom hacked up vent with blue BGA chip heatsinks from china stuck to the cooler.

![Custom Heatsinks detailed](/assets/images/post-images/2019-02-10-my-hacked-lenovo-t420/IMG_2365.jpg){:class="img-center"}
*Closeup of the add-on custom heatsinks*{:class="img-caption"}

## About the CPU

![Hacked Lenovo T420](/assets/images/post-images/2019-02-10-my-hacked-lenovo-t420/t420_full_load.png){:class="img-center"}
*Temperatures and frequencies running a bunch of `yes` instances in Ubuntu 19.10*{:class="img-caption"}

- Intel Core i7-2960XM Extreme Edition (aka "toaster") with power limit set to 53W in BIOS - more than that the cooling (even the discrete gpu cooler) cannot handle. This I ordered from China via eBay.
  - Initially I upgraded this machine to an i7-2760QM and then to an i7-2860qm. In both cases I was limited by thermal issues. I recommend that you buy a lower clocked chip but with the maximum possible cache for efficiency. GPU clocks can also matter, but among these top-tier Sandy Bridge CPUs, all of them run the iGPU at 1.3GHz. Detailed specs on all 2nd Gen mobile i7s [here](https://en.wikipedia.org/wiki/Sandy_Bridge#Mobile_platform).
  - The only reason to upgrade to the i7-2960XM (apart from the bragging rights) is faster single core performance, as the turbo on this CPU can reach 3.7GHz on a single core.

## The search for a 1440p mod

Initial attempts at a 1080p screen on the T420 have produced mixed results. Mostly, [flickering](https://forum.thinkpads.com/viewtopic.php?t=118070&start=210) was reported because of electrical interference between the power circuitry of the laptop and the adapter kit's electronics.

More recently, some chinese fanatics have produced an [adapter kit board](https://www.ebay.com/itm/LCD-controller-board-WQHD-2560X1440-1440p-IPS-Screen-Kit-for-thinkpad-T430-T420/153466233711) that will allow you to replace the nasty 1600x900 TN screen with a 2560x1440 resolution panel of the IPS flavor. That's a lot of pixels!

### Picking a panel

According to the mod chip specs, compatible 1440p panels are rare. It is also common to find many ebay sellers who claim to ship you a "compatible" part instead of the panel with an exact part number that you are looking for. Beware of this, as the "compatible" part will most likely not be compatible with the mod chip.

Taking a look at the possible models, I have compiled the specs for easy comparison using Panellook.org's Compare Tool [here](http://www.panelook.com/modelcompare.php?ids=33382,25359,21975,21977,31862,34048) (pdf version [here](/assets/images/post-images/2019-02-10-my-hacked-lenovo-t420/t420_panels.pdf)).

#### Matching Lenovo Part Numbers to Panel References

One of the possible ways to avoid buying a "compatible" part is to buy a boxed Lenovo component (search by its FRU), so you are sure of what panel comes inside.

Here are some references I was able to find. Antiglare/glossy info from Panellook and ebay listings.

| Lenovo FRU       | Panel Part Numbers | Type      |
| ---------------- | ------------------ | --------- |
| 00NY412          | LP140QH1-SPE3      | [Antiglare](https://www.ebay.com/itm/LP140QH1-SP-E3-14-0-3K-QHD-LED-Display-2560x1440-40-Pin-eDP-matt-00NY412/263489106971?hash=item3d592cb41b:g:xUYAAOSwfphafu~K) |
| 00HN877, 00HN878 | LP140QH1-SPF1      | Antiglare |
| 00HN827          | LP140QH1-SPA2      | Glossy    |
| 00NY440          | B140QAN01.5      | Glossy    |
| 00HN826          | B140QAN01.1      | Glossy    |


{% include info.html content="Page in construction" %}
