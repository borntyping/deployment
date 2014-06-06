#
# Basic system tools
#

package 'nano'
package 'tree'
package 'htop'
package 'tmux'
package 'jq'
package 'ack-grep'

execute 'Link /usr/bin/ack' do
  command 'dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep'
  creates '/usr/bin/ack'
end
