#!/bin/bash

NS_DIR=/etc/128technology/plugins/network-scripts/host/wireguard/
mkdir $NS_DIR
cp init monitoring $NS_DIR
chmod 755 $NS_DIR/*
ln -s init $NS_DIR/reinit

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
