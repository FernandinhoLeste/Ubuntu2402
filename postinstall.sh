#!/bin/sh

    apt-get update
    # Instala dependências necessárias para o Netskope
    apt-get install -y libgtk-3-0 libwebkit2gtk-4.0-37 libappindicator3-1
    # Faz download do script do Netskope e armazena no tmp
    wget https://nmd-nsclient.s3.amazonaws.com/NSClient.run -O /tmp/NSClient.run
    # Adiciona permissão de execução no script do Netskope
    chmod +x /tmp/NSClient.run
    # Executa o script de instalação do Netskope
    sh /tmp/NSClient.run -i -t nomadtecnologia-br -d eu.goskope.com
    # Coleta o nome de usuário logado
    USER=$(users)
    # Coleta o UID do usuário
    IDUSER=`id $USER | awk -F'[=($]' '{print $2}'`
    # Executa o processo para habilitar o agente do Netskope
    su -c "XDG_RUNTIME_DIR="/run/user/$IDUSER" DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus" systemctl --user --now enable stagentapp.service" $USER
    # Pausa
    sleep 5
    # Exibe o processo do agente em execução
    ps -ax -o user:96,pid,cmd | grep "[s]tAgentApp"
    # Instala e configura o Falcon Sensor
    export FALCON_CLIENT_ID="89c3c3b706a942ac95fa77b6ff1d8104"
    export FALCON_CLIENT_SECRET="Ubx5E3CfFNIL0T1Oksehjl279BZMXp8u6WSPHm4y"
    curl -L https://raw.githubusercontent.com/crowdstrike/falcon-linux-install-bash/main/falcon-linux-deploy.sh | bash
    # Habilita o serviço para iniciar na inicialização
    systemctl enable falcon-sensor
    # Verifica o status do serviço
    systemctl status falcon-sensor