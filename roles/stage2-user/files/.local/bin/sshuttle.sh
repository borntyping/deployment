#!/bin/bash
exec /usr/bin/sshuttle \
    --ssh-cmd "ssh -F /home/sam/.ssh/config" \
    --remote "example" \
    "EXAMPLE"
