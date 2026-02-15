sudo apt update
sudo apt install neovim stow zsh -y

chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git config --global user.email "abilev.nurbek@gmail.com"
git config --global user.name "nurbekabilev"

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
