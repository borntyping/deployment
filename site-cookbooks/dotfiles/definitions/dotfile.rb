#
# Wrapper around the template resource used to create dotfiles
#

define :dotfile, :action => :create, :source => nil do
  # Set a default source using the template name
  params[:source] = params[:name] + '.erb' if params[:source].nil?

  # Strip the initial dot from source paths
  params[:source] = params[:source][1..-1] if params[:source][0] == '.'

  template params[:name] do
    path File.absolute_path(params[:name], node[:dotfiles][:home])
    source params[:source]
    manage_symlink_source false
    owner node[:dotfiles][:user]
    group node[:dotfiles][:group]
    action params[:action]
  end
end
