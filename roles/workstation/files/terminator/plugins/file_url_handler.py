from __future__ import print_function

import inspect
import os
import os.path
import subprocess

import terminatorlib.plugin as plugin

AVAILABLE = ['FileURLHandler']


class FileURLHandler(plugin.URLHandler):
    capabilities = ['url_handler']
    handler_name = 'FileURLHandler'

    match = r'[a-zA-Z0-9_-/\.]*(:[0-9]*)?'

    def get_cwd(self):
        """ Return current working directory. """
        # HACK: Because the current working directory is not available to
        # plugins, we need to use the inspect module to climb up the stack to
        # the Terminal object and call get_cwd() from there.
        for frameinfo in inspect.stack():
            frameobj = frameinfo[0].f_locals.get('self')
            if frameobj and frameobj.__class__.__name__ == 'Terminal':
                return frameobj.get_cwd()
        return None

    def callback(self, url):
        """Open the url in IDEA."""

        path = os.path.join(self.get_cwd(), url)
        print('Opening {} in Intellij IDEA'.format(path))
        subprocess.Popen(['idea', path])

        # Stop `xdg-open` opening a second instance of the URL.
        return '--version'
