#!/bin/bash

sudo apt-get update
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb
sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb
sudo apt-get install -f -y
rm /tmp/google-chrome-stable_current_amd64.deb

if command -v google-chrome > /dev/null; then
    echo "Google Chrome instalado com sucesso!"
else
    echo "Houve um problema na instalação do Google Chrome."
fi


