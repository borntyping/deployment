#!/usr/bin/python
"""Ansible module for pipsi"""

import os.path


def main():
    state_map = {
        'present': 'install',
        'absent': 'uninstall',
    }

    module = AnsibleModule(
        argument_spec={
            'state': {
                'default': 'present',
                'choices': state_map.keys()
            },
            'name': {
                'required': True,
                'type': 'str'
            },
            'home': {
                'default': '~/.local/venvs',
                'required': False,
                'type': 'str'
            },
            'bindir': {
                'default': '~/.local/bin',
                'required': False,
                'type': 'str'
            },
            'python': {
                'default': 'python',
                'required': False,
                'type': 'str'
            }
        },
        supports_check_mode=True
    )

    # Expand any directories passed as arguments
    module.params['home'] = os.path.expanduser(module.params['home'])
    module.params['bindir'] = os.path.expanduser(module.params['bindir'])

    # (state=present) If the package is already installed do nothing
    path = os.path.join(module.params['home'], module.params['name'])
    if module.params['state'] == 'present' and os.path.exists(path):
        module.exit_json(changed=False)

    cmd = "{pipsi} --home={home} {action} {package}".format(
        pipsi=module.get_bin_path('pipsi', True, [module.params['bindir']]),
        home=module.params['home'],
        action=state_map[module.params['state']],
        package=module.params['name'])

    if module.params['state'] == 'present':
        python = module.get_bin_path(module.params['python'], True)
        cmd = cmd.format("{} --python={}", cmd, python)

    if not module.check_mode:
        rc, stdout, stderr = module.run_command(cmd, check_rc=True)

    module.exit_json(
        changed=True,
        cmd=cmd,
        name=module.params['name'],
        state=module.params['state'])


from ansible.module_utils.basic import *  # noqa

main()
