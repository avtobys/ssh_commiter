#!/usr/bin/env bash

SSH_PORT=22
SSH_USER=root
SSH_SERVER=192.168.56.111
SSH_PATH=/var/www/user/public_html
SSH_OG=username:groupname # recursive owner:group from chown -R SSH_PATH
RSA_PATH=/c/Users/Username/.ssh/id_rsa # your rsa key

if [[ -z "$(ssh-add -l | grep -i rsa)" ]]; then
    eval `ssh-agent`
    ssh-add $RSA_PATH
fi

rsync -avzhP -e "ssh -p $SSH_PORT" --exclude=.vscode --exclude=inc/db.php --exclude=commit.sh ./ "$SSH_USER@$SSH_SERVER:$SSH_PATH"
ssh -p $SSH_PORT "$SSH_USER@$SSH_SERVER" "chown -R $SSH_OG $SSH_PATH"
