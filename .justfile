export ANSIBLE_NOCOWS := "true"
export ANSIBLE_RETRY_FILES_ENABLED := "false"
export PIP_REQUIRE_VIRTUALENV := "0"

configure limit="localhost" tags="all":
  ansible-playbook "playbook.yml" \
    --diff \
    --inventory-file="inventory.yml" \
    --limit="{{ limit }}" \
    --tags="{{ tags }}"
