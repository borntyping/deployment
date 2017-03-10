#!/bin/zsh
#
# Load virtualenvwrapper, and stop virtualenv from modifying the prompt
#

if [[ -f /usr/share/virtualenvwrapper/virtualenvwrapper.sh ]]; then
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
    export VIRTUAL_ENV_DISABLE_PROMPT=1
    source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
fi
