deployment
==========

Deploys dotfiles, configuration and packages to my machines using Ansible.

Usage
-----

Install Ansible first (and some other immediately useful packages).

```bash
sudo apt update
sudo apt install ansible git tilix curl
```

Clone this repository, then create an inventory file and run the
`./reconfigure` script.

```bash
git clone https://github.com/borntyping/deployment.git
cd deployment
echo "ansible_sudo_pass=<password>" > "host_vars/localhost.yml"
./reconfigure
```

You may need to add some missing gpg keys.

```bash
curl -L https://packagecloud.io/github/git-lfs/gpgkey | sudo apt-key add -
```

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

Copyright (c) 2014-2020 Sam Clements

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
