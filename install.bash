#!/bin/bash

SCRIPTS_DIR=/etc/128technology/plugins/network-scripts/wireguard
mkdir $SCRIPTS_DIR
cp namespace-scripts/* $SCRIPTS_DIR
chmod 755 $SCRIPTS_DIR/*/*
ln -s init $SCRIPTS_DIR/egress/reinit
ln -s init $SCRIPTS_DIR/ingress/reinit

mkdir /etc/128technology/wireguard/
CONFIG=/etc/128technology/wireguard/_sample_.conf
if [ ! -e $CONFIG ]; then
    {
        echo "[Interface]"
        echo "PrivateKey = $(/bin/wg genkey)"
        echo "Address = 10.0.0.1/32"
        echo "ListenPort = 51820"
    } > $CONFIG
fi

cp 128t-wireguard@.service /usr/lib/systemd/system/
systemctl daemon-reload
