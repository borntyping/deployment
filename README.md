deployment
==========

Deploys dotfiles, configuration and packages to my machines using Ansible.

Usage
-----

Download the repository, create an inventory file, and run the `./reconfigure`
script.

### Installing ansible

Install the latest ansible release with:

```bash
sudo apt-add-repository --yes ppa:ansible/ansible
sudo apt update
sudo apt install ansible git tilix curl
sudo apt install cinnamon-core # optional
curl -L https://packagecloud.io/github/git-lfs/gpgkey | sudo apt-key add -
```

### Fetch this repository

Clone this repository:

```bash
git clone https://github.com/borntyping/deployment.git
cd deployment
```

### Create an inventory file

Create an inventory file named `./inventory.conf`. An example inventory might
look like this:

```
[workstation]
localhost ansible_connection=local ansible_sudo_pass=EXAMPLE
```

If you don't want to create an inventory file, and only want to configure the
local machine, you can pass `--inventory=localhost,` as an argument to
`./reconfigure`.

### Run ansible

```bash
./reconfigure
```

Bootstrapping a new server
--------------------------

If the OS was not created with a personal user, create one before running the
above instructions:

```bash
adduser sam
usermod -a -G sudo sam
```

You can the either run Ansible from your workstation by adding a remote
connection to the inventory, or directly on the machine you are bootstrapping.
To run Ansible directly on the machine:

```bash
ansible-pull --url=git@github.com:borntyping/deployment.git -i localhost, -K site.yml
```

Once ansible has run, set passwords for any additional users:

```bash
sudo passwd USER
```

Post-ansible setup
------------------

Ansible sets up everything possible automatically, but there are still some
things that must be done manually on a new workstation:

- Set keyboard shortcuts (workspace switching, terminal).
- Start the Dropbox client to run the proprietary installer.

Afterwards, you should login to various applications:

- Dropbox
- Firefox
- Slack
- Steam

There are also some things this repository doesn't do yet:

- Install [Rust] and development tools (rustfmt, racer).
- Configure the Slack repository.
- Configure startup applications.
- Hide desktop icons.

Development
-----------

Some dependencies are managed using [Peru], which is installed by the
`stage2-user` role. Once the development machine is bootstrapped you can run
`peru reup` to update those files, which will fetch the lastest versions of the
dependecies and copy them into this repository. Tasks that install these files
are tagged with `peru`, so updating the deployed versions of those files can be
done with `./reconfigure -t peru`.

Licence
-------

The MIT License (MIT)

Copyright (c) 2014-2016 Sam Clements

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

[Peru]: https://github.com/buildinspace/peru
