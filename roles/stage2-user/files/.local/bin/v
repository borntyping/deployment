#!/usr/bin/env bash
#
# A tiny virtualenv manager
#
# Author: Sam Clements <sam@borntyping.co.uk>
# Homepage: https://github.com/borntyping/v
# Version: 4.0.0
#

set -e

# Runs a hook script if it exists in the current $V_HOME
function run_hook() {
    if [[ -f $V_HOME/$1 ]]; then
        source "$V_HOME/$1"
    fi
}

function main() {
    # Show the usage message if args contains --help or -h
    if [[ $@ =~ --help || $@ =~ -h ]]; then
        echo "Usage: v [name] [python]"
        echo
        echo "Activates or creates a virtualenv using virtualenvwrapper"
        echo "[name] defaults to 'default' and [python] defaults to $(which python3)"
        exit
    fi

    declare V_NAME
    declare V_PYTHON
    declare V_HOME
    declare V_VIRTUALENV_CREATED

    # Use 'default' as the default name
    # $1 -> V_DEFAULT -> 'default'
    V_NAME=${1:-$V_DEFAULT_NAME}
    V_NAME=${1:-default}

    # Use the system's python by default
    # $2 -> V_DEFAULT_PYTHON -> $(which python)
    V_PYTHON=${2:-$V_DEFAULT_PYTHON}
    V_PYTHON=${2:-$(which python3)}

    # Select a directory virtualenvs will be placed in
    # This is also where hooks will be looked for
    # $V_HOME -> $WORKON_HOME -> $HOME/.virtualenv
    V_HOME=${V_HOME:=$WORKON_HOME}
    V_HOME=${V_HOME:=$HOME/.virtualenvs}

    # Create the virtualenv if it does not already exist
    if [[ ! -d "$V_HOME/$V_NAME" || ! -f "$V_HOME/$V_NAME/bin/python" ]]; then
        virtualenv -p "$V_PYTHON" "$V_HOME/$V_NAME"
        run_hook "premkvirtualenv"
        V_VIRTUALENV_CREATED=true
    else
        V_VIRTUALENV_CREATED=false
    fi

    # Export the environment that configures the virtualenv
    # This also runs the pre- and post- activate hooks
    run_hook "preactivate"
    unset PYTHON_HOME
    export VIRTUAL_ENV="$V_HOME/$V_NAME"
    export PATH="$V_HOME/$V_NAME/bin:$PATH"
    run_hook "postactivate"

    # Run the postmkvirtualenv hook if we created the virtualenv
    if [[ $V_VIRTUALENV_CREATED == true ]]; then
        run_hook "postmkvirtualenv"
    fi

    # Cleanup variables only used for this script
    unset V_NAME
    unset V_PYTHON
    unset V_HOME
    unset V_VIRTUALENV_CREATED

    # Start a new shell using the environment previously set up
    exec "$SHELL"
}

main "$@"
