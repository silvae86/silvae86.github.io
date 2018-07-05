#!/usr/bin/env bash

# If you use XCode Beta...
# sudo xcode-select --switch /Applications/Xcode-beta.app/Contents/Developer
# I had the same issue and I solved by doing the following:

# removing the old tools ($ rm -rf /Library/Developer/CommandLineTools)
# install xcode command line tools again ($ xcode-select --install).

# return to old XCode libraries?
# sudo xcode-select -s /Library/Developer/CommandLineTools


# /Applications/Xcode-beta.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/libxml2

# brew reinstall python@2
# brew reinstall libxml2

# SOLUTION!
# Mojave Headers:
# https://forums.developer.apple.com/thread/104296
# cp /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg ~/Desktop

# if the legacy headers are not installed (for OS X Mojave):
if [ ! -f /usr/include ]
then
    sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /
fi 

#install nvm
\curl -sSL https://get.rvm.io | bash

#activate rvm
source ~/.rvm/scripts/rvm

#install latest ruby
rvm install 2.5.1

#use latest ruby
rvm use 2.5.1

#set default ruby
rvm default 2.5.1

# install dependencies for responsive images
brew unlink imagemagick
brew uninstall imagemagick
brew install imagemagick@6
brew install imagemagick@6 && brew link imagemagick@6 --force


#install jekyll and bundle
gem install jekyll bundle
gem install rmagick

#install deps
bundle install

#serve blog
bundle exec jekyll serve


########################## JUNK 

# # brew install libxml2
# # brew link libxml2 --force

# PKG_CONFIG_PATH=/usr/local/opt/libxml2/lib/pkgconfig pkg-config --cflags libxml-2.0

# # export sbin to path if not already there
# if [[ $(cat $HOME/.zshrc | grep "export PATH=\"/usr/local/opt/libxml2/bin:\$PATH\"") ]]
# then
#     echo 'export PATH="/usr/local/opt/libxml2/bin:$PATH"' >> ~/.zshrc
# fi

# # export sbin to path if not already there
# if [[ $(cat $HOME/.zshrc | grep "export PATH=\"/usr/local/sbin:\$PATH\"") ]]
# then
#     echo 'export PATH="/usr/local/sbin:$PATH"' >> $HOME/.zshrc
# fi
