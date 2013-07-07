#!/bin/sh

[ -x /usr/bin/emacs ] || sudo apt-get -y install emacs

if [ `hostname` != "alcazar" ]; then
    sudo ./configure_nfs
fi

sudo ./configure_users_groups

# SSH stuff
if [ ! -f ~/.ssh/id_rsa ]; then 
    scp -pr ivan@alcazar:/home/ivan/.ssh /home/ivan/.ssh
fi

# emacs init
if [ ! -d ~/.emacs.d/.git ]; then
    [ -d ~/.emacs.d ] && mv ~/.emacs.d ~/.emacs.d.$$
    git clone ivan@alcazar:/media/Documents/git/emacs_config.git ~/.emacs.d
    (cd ~/.emacs.d; ./setup_vendors.sh)
fi

if [ ! -f ~/.gitconfig ]; then
    git config --global user.name "Ivan Vazquez"
    git config --global user.email ivan@ivanvazquez.com
fi

cp -r dot-config/* ~/.config
