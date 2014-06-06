#
# pip package resource
#

actions :install
default_action :install

attribute :package, :kind_of => String, :name_attribute => true
attribute :version, :default => ''
attribute :python, :default => 'python2.7'
