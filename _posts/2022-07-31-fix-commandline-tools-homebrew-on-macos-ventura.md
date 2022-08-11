---
layout: post
title:  "Homebrew: Fix Command Line Tools installation on macOS Ventura Beta"
date: 2022-07-30 14:36:000 +0100
tags: macos ventura homebrew xcode command-line tools
published: true
comments_id: 50
---

1. Install XCode Beta 14.0 from Apple's Developer website.
2. Open XCode, set path to command line tools using XCode GUI

{% include image.html src="/assets/images/post-images/2022-07-31-fix-commandline-tools-homebrew-on-macos-ventura/commandline-tools.png"
caption="Preferences dialog in XCode 14.0 - Setting up the Command Line Tools home" imageposition="center"
title="Commandline Tools - XCode Preferences"
%}

3. Download the homebrew install script, disable check for command line tools

```bash
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh > install.sh
```

Open `install.sh`, and replace

```bash
should_install_command_line_tools() {
	-----
}
```

with

```bash
should_install_command_line_tools() {
	return false;
}
```

4. Homebrew will stop complaining and casks will install now:

{% include image.html src="/assets/images/post-images/2022-07-31-fix-commandline-tools-homebrew-on-macos-ventura/disable-commandline-tools-install.jpg"
caption="Modifying the homebrew install script not to install Commandline Tools" imageposition="center"
title="Disable Commandline Tools Install"
%}