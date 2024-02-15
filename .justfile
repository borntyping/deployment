export ANSIBLE_NOCOWS := "true"
export ANSIBLE_RETRY_FILES_ENABLED := "false"
export ANSIBLE_PIPELINING := "true"
export PIP_REQUIRE_VIRTUALENV := "0"
configure limit="${HOSTNAME}" tags="all":
  ansible-playbook "playbook.yml" \
    --diff \
    --inventory-file="inventory.yml" \
    --limit="{{ limit }}" \
    --tags="{{ tags }}"

install:
  ansible-galaxy collection install --requirements-file 'collections/requirements.yml'
