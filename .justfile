export ANSIBLE_NOCOWS := "true"
export ANSIBLE_RETRY_FILES_ENABLED := "false"
export PIP_REQUIRE_VIRTUALENV := "0"

configure tags="all":
  ansible-playbook "playbook-workstation.yml" \
    --diff \
    --inventory-file=inventory.yml \
    --extra-vars="ansible_connection=local" \
    --tags="{{ tags }}"

configure-server server tags="all":
  ansible-playbook "playbook-server.yml" \
    --diff \
    --inventory-file=inventory.yml \
    --extra-vars="ansible_host={{ server }}" \
    --tags="{{ tags }}"
