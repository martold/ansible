#!/bin/bash

HOST={{ var }}
PLAYBOOK_PATH=$HOME/allshit/ansible

SCRIPT1='sudo su && adduser martold && usermod -aG sudo martold && echo "martold ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers'
SCRIPT2='userdel ubuntu && systemctl restart sshd'
SCRIPT3='sudo su && curl -O https://raw.githubusercontent.com/angristan/wireguard-install/master/wireguard-install.sh
chmod +x wireguard-install.sh
yes | ./wireguard-install.sh'

ssh -i $HOME/.ssh/VPN.pem ubuntu@${HOST} '${SCRIPT1}'
ssh -i $HOME/.ssh/VPN.pem ubuntu@${HOST} '${SCRIPT2}'
ssh -i $HOME/.ssh/VPN.pem ubuntu@${HOST} '${SCRIPT3}'
scp -i $HOME/.ssh/VPN.pem ${PLAYBOOK_PATH}/files/sshd_config ubuntu@${HOST}://etc/ssh/sshd_config
