# Chef-solo configuration

require 'socket'

chef_repo_path File.dirname(File.realpath(__FILE__))
node_name Socket.gethostname

# Chef data directories
cookbook_path File.join(chef_repo_path, 'site-cookbooks')
role_path File.join(chef_repo_path, 'roles')

# The attribute file for the current host
# json_attribs File.join(chef_repo_path, 'nodes', "#{node_name}.json")

# Don't show diffs for large files
Chef::Config[:diff_output_threshold] = 25000

# Verify all HTTPS connections
ssl_verify_mode :verify_peer
