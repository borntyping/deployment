deployment
==========

Deploys dotfiles, configuration and packages to my machines using Ansible.

Usage
-----

Install essential dependencies:

```bash
sudo dnf install ansible-core git git-lfs micro
```

Clone this repository:

```bash
mkdir -p "~/Development/github.com/borntyping"
cd "~/Development/github.com/borntyping"
git clone 'https://github.com/borntyping/deployment.git'
cd "deployment"
```

Install Ansible collections:

```bash
ansible-galaxy collection install --requirements-file 'collections/requirements.yml'
```

Create the local machine's inventory:

```bash
cp 'host_vars/example.yml' 'host_vars/localhost.yml'
micro 'host_vars/localhost.yml'
```

Run the playbook:

```bash
./reconfigure
```

Open `tilix`, and install ZSH plugins:

```zsh
miniplug install
```

If you run into line ending issues as you cloned the repo with GitHub Desktop and are using it inside a WSL distribution:

```bash
git config --global core.eol lf
git config --global core.autocrlf input
git reset --hard
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
