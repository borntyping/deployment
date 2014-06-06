#
# Installs Python 2 and 3
#

package 'python'
package 'python-pip'

package 'python3'
package 'python3-pip'

system_pip 'setuptools' do
  version '>=4'
  action :install
end
