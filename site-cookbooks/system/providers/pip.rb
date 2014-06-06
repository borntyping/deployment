#
# Installs or uninstalls a Python package
#

require 'yaml'

require 'chef/mixin/shell_out'
include Chef::Mixin::ShellOut

action :install do
  command = "#{pip} install #{new_resource.package}#{new_resource.version}"
  converge_by(command) { shell_out(command) }
end

def load_current_resource
  @current_resource = Chef::Resource::SystemPip.new(new_resource.name)
  @current_resource.package(new_resource.package)
  @current_resource.version(load_current_version)
  @current_resource
end

def load_current_version
  r = shell_out("#{pip} show #{new_resource.package}")
  r.exitstatus == 0 ? YAML.load(r.stdout)['Version'] : nil
end

def pip
  "#{new_resource.python} -m pip"
end
