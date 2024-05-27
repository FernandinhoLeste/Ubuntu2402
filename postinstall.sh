#!/bin/bash
#Instalação Google Chrome
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

#Instalação JumpCloud
curl --tlsv1.2 --silent --show-error --header 'x-connect-key: ca54fc037d798fb2e1103c7cb8a486ac4941bb64' https://kickstart.jumpcloud.com/Kickstart | sudo bash

#Instalação Wazuh
wget https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.6.0-1_amd64.deb && sudo WAZUH_MANAGER='starwatch.benomad-sec.internal' WAZUH_AGENT_GROUP='LNX_EndUsers' dpkg -i ./wazuh-agent_4.6.0-1_amd64.deb

sudo systemctl daemon-reload
sudo systemctl enable wazuh-agent
sudo systemctl start wazuh-agent


