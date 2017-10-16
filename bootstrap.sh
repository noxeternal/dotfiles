#!/usr/bin/env bash

APT="apt-transport-https zsh git nano stow tmux htop curl wget ruby gems"

echo "apt update..."
sudo apt update
#sudo apt upgrade
#sudo apt autoremove

echo "apt install... ("$APT")"
sudo apt install -y $APT

echo "installing tmuxinator..."
sudo gem install tmuxinator

pushd $HOME
	echo "cloning dotfiles..."
	git clone https://github.com/noxeternal/dotfiles src/dotfiles

	echo "changing shell..."
	sudo usermod -s /bin/zsh $USER

	echo "Cloning oh-my-zsh..."
	if [[ ! -e .oh-my-zsh ]]
	then
		git clone https://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh
	fi

	echo "Removing initial files..."
	rm -v .bashrc .bash_logout

	echo "Creating directories..."
	mkdir -p .config
	mkdir -p bin

	echo "Symlinking..."
	pushd src/dotfiles
		stow -t $HOME bash zsh git tmux jshint
		stow -t $HOME/.config _config
		stow -t $HOME/bin _bin
	popd
popd

echo "fin."
echo ""
