# macOS_setup

[![Build Status](https://travis-ci.org/rabafea/OS_setup.svg?branch=master)](https://travis-ci.org/rabafea/OS_setup)

## Install homebrew
```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## Install pip and ansible
```
sudo easy_install pip
sudo pip install ansible
```

## Run playbook
```
ansible-playbook -i inventory main.yml
```
