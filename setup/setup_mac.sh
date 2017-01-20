#!/bin/bash

#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(which brew)
then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" > /tmp/homebrew-install.log
fi

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Install GNU core utilities (those that come with OS X are outdated)
brew install grc coreutils
echo "Don’t forget to add $(brew --prefix coreutils)/libexec/gnubin to \$PATH."
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4
brew install bash
brew install zsh

# Install wget with IRI support
brew install wget --with-iri
brew install curl --with-ssl --with-ssh
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew install homebrew/dupes/grep

# Install everything else
brew install git git-extras hub git-ftp
brew install rename htop-osx tree ngrep mtr nmap
brew install autojump
brew install legit # http://www.git-legit.org/
brew install Zopfli # https://code.google.com/p/zopfli/
brew install ngrok # https://ngrok.com/

# Native apps
brew tap phinze/homebrew-cask
brew install brew-cask
function installcask() {
    if brew cask info "${@}" | grep "Not installed" > /dev/null; then
        brew cask install "${@}"
    else
        echo "${@} is already installed."
    fi
}

installcask google-chrome
installcask dropbox
installcask iterm2
installcask vlc
installcask nvalt  # for notes
installcask qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql webp-quicklook suspicious-package && qlmanage -r

# Fonts
brew tap caskroom/fonts

brew cask install font-source-code-pro

# SpotifyControl
# git clone git://github.com/dronir/SpotifyControl.git ~/bin/SpotifyControl

sudo easy_install pip

# Remove outdated versions from the cellar
brew cleanup && brew cask cleanup

exit 0
