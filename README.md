deployment
==========

Deploys dotfiles, configuration and packages to my workstations using Ansible.

Usage
-----

To pull the repository and run the playbook against the local machine in one command:

```bash
ansible-pull --url=git@github.com:borntyping/deployment.git -i localhost, -K site.yml
```

If you intend to modify the repository:

```bash
git clone git@github.com:borntyping/deployment.git
cd deployment
$EDITOR inventory.conf
./ansible-run
```

The `./ansible-run` script is a wrapper around `ansible-playbook`, and requires an inventory file to exist at `./inventory.conf` (it'll remind you if you forget to create it). An example inventory might look like this:

```
[workstation]
localhost ansible_connection=local ansible_sudo_pass=EXAMPLE

[servers]
remotehost ansible_ssh_host=remotehost.example.co.uk ansible_ssh_port=22 ansible_sudo_pass=EXAMPLE
```

If you don't want to create an inventory file, and only want to configure the local machine, you can pass `--inventory=localhost,` as an argument to `./ansible-run` or `ansible-playbook` (which is what the `ansible-pull` command above does).

Bootstrapping
-------------

After logging in as the root user:

 * Create personal user with `adduser USER`
 * Add personal user to sudoers with `usermod -a -G sudo USER`

Add the machine to the inventory:

    HOSTNAME ansible_sudo_pass=PASSWORD

After ansible has run:

 * Set user passwords with `passwd USER`

Licence
-------

The MIT License (MIT)

Copyright (c) 2014 Sam Clements

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
