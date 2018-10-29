#!/bin/bash

# Install prerequisites
yes | sudo yum update
yes | yum groupinstall "Development Tools"
yes | sudo yum install ncurses-devel

# Download sources and build zsh
cd /usr/local/src
sudo curl -L https://sourceforge.net/projects/zsh/files/latest/download -o zsh.tar.xz
sudo tar xvf zsh.tar.xz
cd zsh-*
sudo ./configure && sudo make && sudo make install

# Add zsh to list of shells
echo '/usr/local/bin/zsh' | sudo tee --append /etc/shells

# Change default shell for selected user
echo "Enter username to change its shell to zsh: "
read username
if getent passwd $username > /dev/null 2>&1; then
    chsh --shell /usr/local/bin/zsh $username
    echo "Done! $username shell was changed to zsh."
else
    echo "User does not exist."
fi
