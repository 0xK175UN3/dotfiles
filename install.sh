# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `this script` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


echo "Installing all your stuff!"
echo ""

echo ""
echo "---> Zsh"
chsh -s /bin/zsh
echo "---> Zsh done"
# Brew
echo ""
echo "---> Brew"
brew tap Homebrew/bundle
cd ~/.dotfiles/brew/ && brew bundle
cd ~/.dotfiles/
echo "---> Brew done"

echo "---> Post brew"
$(brew --prefix)/opt/fzf/install
echo "---> Post brew done"

echo ""
echo "---> Git"
ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/git/gitignore_global ~/.gitignore_global
echo "---> Git done"

echo ""
echo "---> Go "
bash ~/.dotfiles/go/install.sh
echo "---> Go done"

echo "---> OSX"
bash ~/.dotfiles/osx.sh
echo "---> OSX done"