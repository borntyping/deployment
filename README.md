deployment
==========

Deploys dotfiles, configuration and packages to my machines using Ansible.

Usage
-----

Download the repository, create an inventory file, and run the `./ansible-run` script.

### Installing ansible

Install the latest ansible release with:

```bash
sudo apt-add-repository --yes ppa:ansible/ansible
sudo aptitude update
sudo aptitude install ansible
```

### Managing a workstation

The `./ansible-run` script is a wrapper around `ansible-playbook`, and requires an inventory file to exist at `./inventory.conf`. An example inventory might look like this:

```
[workstation]
localhost ansible_connection=local ansible_sudo_pass=EXAMPLE

[servers]
remotehost ansible_ssh_host=remotehost.example.co.uk ansible_ssh_port=22 ansible_sudo_pass=EXAMPLE
```

If you don't want to create an inventory file, and only want to configure the local machine, you can pass `--inventory=localhost,` as an argument to `./ansible-run`.

### Bootstrapping a new machine

If the OS was not created with a personal user, create one:

```bash
adduser sam
usermod -a -G sudo sam
```

You can the either run Ansible from your workstation, or directly on the machine you are bootstrapping.

To run Ansible directly on the machine:

```bash
ansible-pull --url=git@github.com:borntyping/deployment.git -i localhost, -K site.yml
```

Or add the machine to the inventory and run it from your workstation:

```
HOSTNAME ansible_sudo_pass=PASSWORD
```

```bash
./ansible-run
```

Once ansible has run, set passwords for any addtional users:

```bash
sudo passwd USER
```

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
