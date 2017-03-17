#!/bin/zsh
#
# Configures Ansible to use user directories.
#
export ANSIBLE_VAULT_PASSWORD_FILE=~/.ansible-secret
export ANSIBLE_INVENTORY=~/Development/generalbioinformatics/ansible/inventory.conf
