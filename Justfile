playbook := if path_exists("playbook.local.yml") == "true" { "playbook.local.yml" } else { "playbook.yml" }
inventory := if path_exists("inventory.local.yml") == "true" { "inventory.local.yml" } else { "inventory.yml" }
hostname := `hostname -s`
export ANSIBLE_CACHE_PLUGIN := "ansible.builtin.jsonfile"
export ANSIBLE_CACHE_PLUGIN_CONNECTION := ".ansible-cache"
export ANSIBLE_NOCOWS := "true"
export ANSIBLE_PIPELINING := "true"
export ANSIBLE_RETRY_FILES_ENABLED := "false"
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

# Create a local-only configuration
local-init hostname=hostname:
    cp --update=none "{{ playbook }}" "playbook.local.yml"
    cp --update=none "{{ inventory }}" "inventory.local.yml"
    cp --update=none --no-target-directory --recursive "host_vars/example" "host_vars/{{ hostname }}"
