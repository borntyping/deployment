from __future__ import print_function

import os
import os.path
import subprocess

import terminatorlib.plugin as plugin

AVAILABLE = ['FileURLHandler']


class FileURLHandler(plugin.URLHandler):
    capabilities = ['url_handler']
    handler_name = 'FileURLHandler'

    match = r'[a-zA-Z0-9_-/\.]*(:[0-9]*)?'

    def callback(self, url):
        """Open the url in IDEA."""

        path = os.path.abspath(url)
        print('Opening {} in Intellij IDEA'.format(path))
        subprocess.Popen(['idea', path])

        # Stop `xdg-open` opening a second instance of the URL.
        return '--version'
