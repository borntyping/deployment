deployment
==========

Deploys dotfiles, configuration and packages to my machines using Ansible.

## Usage

### Clone the repo and install dependencies

Install essential dependencies.

```shell
sudo dnf install ansible-core just git git-lfs micro
```

Clone this repository.

```shell
mkdir -p "~/Development/github.com/borntyping"
cd "~/Development/github.com/borntyping"
git clone 'https://github.com/borntyping/deployment.git'
cd "deployment"
```

If you run into line ending issues as you cloned the repo with GitHub Desktop and are using it inside a WSL distribution:

```shell
git config --global core.eol lf
git config --global core.autocrlf input
git reset --hard
```

Install git-lfs (because you didn't listen the first time round), and checkout lfs files.

```shell
sudo dnf install git-lfs
git lfs fetch
git lfs checkout
```

Install Ansible collections.
You'll have to do this manually if you don't have `just` installed yet.

```shell
just install
```

```shell
ansible-galaxy collection install --requirements-file 'collections/requirements.yml'
```

### Optional: Create a local Ansible configuration

This will create `playbook.local.yml` and `inventory.local.yml`, which can be used to
configure machines without committing any details about them to the repository.

```shell
just local-init
```

```shell
cp playbook.yml playbook.local.yml
cp inventory.yml inventory.local.yml
cp host_vars/example host_vars/$(hostname -s)
```

After editing these files, run Ansible with the local files and skip the next section.

```shell
just local-conf
```

```shell
ansible-playbook "playbook.local.yml" --diff --inventory-file="inventory.local.yml" --limit="$(hostname -s)"
```

### Run Ansible for the first time

Run the playbook:

```shell
just configure
```

```shell
ansible-playbook "playbook.yml" --diff --inventory-file="inventory.yml" --limit="$(hostname -s)"
```

### Finish application setup

Open `tilix`, and install ZSH plugins:

```zsh
miniplug install
```

Development
-----------

Some dependencies are managed using [Peru], which is installed by the
`home` role. Once the development machine is bootstrapped you can run
`peru reup` to update those files, which will fetch the latest versions of the
dependencies and copy them into this repository. Tasks that install these files
are tagged with `peru`, so updating the deployed versions of those files can be
done with `./reconfigure -t peru`.

Licence
-------

The MIT License (MIT)

Copyright (c) 2014-2022 Sam Clements

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
