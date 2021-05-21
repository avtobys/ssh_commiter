#!/usr/bin/env bash

# before start commits
# eval `ssh-agent`
# ssh-add /c/Users/Dmitriy/.ssh/id_rsa

SSH_PORT=22
SSH_USER=root
SSH_SERVER=192.168.56.111
SSH_PATH=/var/www/user/public_html
SSH_OG=username:groupname # recursive owner:group from chown -R SSH_PATH

rsync -avzhP -e "ssh -p $SSH_PORT" --exclude=.vscode --exclude=inc/db.php --exclude=commit.sh ./ "$SSH_USER@$SSH_SERVER:$SSH_PATH"
ssh -p $SSH_PORT "$SSH_USER@$SSH_SERVER" "chown -R $SSH_OG $SSH_PATH"
