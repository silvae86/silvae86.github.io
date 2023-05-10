#!/usr/bin/env bash

RUBY_VERSION="2.7.2"
BUNDLER_VERSION="1.16.6"

echo "Installing Ruby $RUBY_VERSION and bundler $BUNDLER_VERSION..."

add_ppa() {
  PPA=$1
  FILE=$2
  grep -h "^deb.*$PPA" /etc/apt/sources.list.d/* > /dev/null 2>&1
  if [ $? -ne 0 ]
  then
    echo "Adding $1 to /etc/apt/sources.list.d/$FILE"
    echo "$1" | sudo tee -a "/etc/apt/sources.list.d/$FILE"
    return 0
  fi

  echo "deb:$PPA already exists"
  return 1
}

activate_rvm() {
  #activate rvm
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
}

# https://askubuntu.com/questions/293838/shell-script-to-conditionally-add-apt-repository
# add_ppa "deb [trusted=yes] http://security.ubuntu.com/ubuntu bionic-security main" "old-bionic-security-for-old-ruby.list"

# https://www.garron.me/en/linux/install-ruby-2-3-3-ubuntu.html
# sudo apt update && apt-cache policy libssl1.0-dev
# sudo apt-get install -y libssl1.0-dev

sudo apt-get update
curl -sSL https://get.rvm.io | bash


#install latest ruby
rvm get stable
rvm autolibs enable
rvm pkg install openssl
rvm install "$RUBY_VERSION" --force --with-openssl-dir="$rvm_path/usr"

activate_rvm

#use latest ruby
rvm use "$RUBY_VERSION"

#set default ruby
rvm default "$RUBY_VERSION"

# install dependencies for responsive imagess
sudo apt-get install libmagickwand-dev imagemagick exiftool

activate_rvm

#install jekyll and bundle
gem update --system
gem install jekyll bundle
gem install rmagick
gem install "bundler:$BUNDLER_VERSION"

# update bundler
bundle update --bundler --full-index

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
