---
layout: post
title:  "Replacing intel_pstate power management with acpi-cpufreq in Ubuntu"
date:   2020-06-13 12:05:000 +0100
tags: ubuntu 20.04 pstate cpu power managmement acpi-cpufreq intel-pstate
---

After upgrading my T420 with a 1440p panel, I noticed some lag in the user interface. On top of that, once the CPU heats up above a certain level, it will be slow until you restart the computer for some reason. This seems to be around 80ºC, which is very normal if you [upgrade](/2019/02/10/my-hacked-lenovo-t420/) your Lenovo T420 to a crazy-hot Quad-Core i7 Extreme CPU like I did.

I believe that the CPU is heating up more after the panel upgrade, perhaps due to additional strain on the iGPU (Intel HD Graphics 3000). Thus, I decided to search for a solution involving better power management in Ubuntu, especially to avoid the lag after any heating up of the processor. My goal is for it to become fast again after the temperature comes back down.

### Seeing your CPU frequency in real time

First, you need a way to see your actual CPU speed to see if any of these changes work.

```bash
watch grep \"cpu MHz\" /proc/cpuinfo
```

### Changing to acpi-cpufreq CPU management driver

```bash
sudo apt-get update
sudo apt-get install acpi-support acpid acpi
```

The idea here is to replace the `intel-pstate` CPU power management driver with the `acpi-cpufreq` one. This allows for better performance and slightly more efficient power use in some cases, as shown [here](https://www.phoronix.com/scan.php?page=article&item=intel_pstate_linux315&num=1).

#### Disable intel-pstate in `grub` config

To disable the default intel-pstate driver, you need to edit `/etc/default/grub`:

```bash
# also hides the splash screen for people like me that like to see log messages on boot instead of a progress bar.
GRUB_CMDLINE_LINUX_DEFAULT="i8042.reset quiet nosplash debug intel_pstate=disable"
```
After making our edits, we need to refresh grub:

```bash
sudo update-grub
```

### Option 1 - cpufrequtils tool family

```bash
sudo apt-get install cpufreqd cpufrequtils indicator-cpufreq
sudo apt-get install -y linux-tools-$(uname -r)

# GUI for editing cpu power configs
sudo apt-get install cpupower-gui
```

#### Adding a nice drop-down menu to choose your CPU frequency in GNOME 3

![Indicator-cpufreq in Gnome Menu](/assets/images/post-images/2020-06-13-switching-to-acpi-power/indicator-cpufreq.png){:class="img-center"}
*Indicator-cpufreq in Gnome Menu*{:class="img-caption"}

Add the following to add to startup applications to have a nice dropdown menu to choose your CPU governor easily. I use the 'ondemand' governor.

![Adding indicator-cpufreq to top bar](/assets/images/post-images/2020-06-13-switching-to-acpi-power/new-startup.png){:class="img-center"}
*Adding indicator-cpufreq to top bar*{:class="img-caption"}

![Adding indicator-cpufreq to top bar - part 2](/assets/images/post-images/2020-06-13-switching-to-acpi-power/startup1.png){:class="img-center"}
*Adding indicator-cpufreq to top bar*{:class="img-caption"}

```bash
# The command in text
indicator-cpufreq &
```

### Option 2 - Install tlp and tlpui

{% include warning.html content="Choose Option 1 or Option 2, not the two at the same time, as having two tools manipulate the CPU governor can cause conflicts!" %}

**Alternatively**, you can install `tlp` and `tlpui` to have this nice GUI to tweak your CPU's power configuration and many other things to your heart's content.

![TLPUI interface](/assets/images/post-images/2020-06-13-switching-to-acpi-power/tlpui.png){:class="img-center"}
*TLPUI interface*{:class="img-caption"}

```bash
sudo add-apt-repository ppa:linuxuprising/apps
sudo apt update
sudo apt install tlp tlpui
```

#### Default `/etc/default/tlp` file

[Here](/assets/images/post-images/2020-06-13-switching-to-acpi-power/tlp) is a default configuration file of the `tlp` utility, in case your `/etc/default/tlp` goes Missing In Action...

### Other nice tools

- [s-tui](https://github.com/amanusk/s-tui) allows you to monitor frequencies in load using the CLI, with a nice interface.
- [throttled](https://github.com/erpalma/throttled) allows you to suppress thermal throttling if needed.
