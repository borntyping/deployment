#
# Installs git, git config files and related tools
#

include_recipe 'system::ruby'

package 'git'
dotfile '.gitconfig'

# git-tag-version (version tagging script)
cookbook_file '/usr/local/bin/git-tag-version' do
  mode '0755'
end

# git-hub (github command line tool)
# http://hub.github.com
gem_package 'git-hub'
