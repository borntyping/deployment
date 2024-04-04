playbook := "playbook.yml"
inventory := "inventory.yml"
hostname := `hostname -s`
export ANSIBLE_NOCOWS := "true"
export ANSIBLE_RETRY_FILES_ENABLED := "false"
export ANSIBLE_PIPELINING := "true"
export PIP_REQUIRE_VIRTUALENV := "0"

# List availible commands
default:
    @just --list

# Run Ansible. Set tags= to run specific tags, set limit= to pick hosts to run against.
configure tags="all" limit=hostname:
    ansible-playbook "{{ playbook }}" \
      --diff \
      --inventory-file="{{ inventory }}" \
      --limit="{{ limit }}" \
      --tags="{{ tags }}"

# Install Ansible dependencies
install:
    ansible-galaxy collection install --requirements-file 'collections/requirements.yml'

# Run a local-only configuration
local-conf tags="all" limit=hostname:
    @just playbook="playbook.local.yml" inventory="inventory.local.yml" tags="{{ tags }}" limit="{{ limit }}"

# Create a local-only configuration
local-init hostname=hostname:
    cp --update=none "{{ playbook }}" "playbook.local.yml"
    cp --update=none "{{ inventory }}" "inventory.local.yml"
    cp --update=none --no-target-directory --recursive "host_vars/example" "host_vars/{{ hostname }}"
