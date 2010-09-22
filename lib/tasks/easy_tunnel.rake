##
# A Rake interface to creating a tunnel using ssh.
# This file originally comes with the facebooker gem for Ruby on Rails: http://github.com/mmangino/facebooker
#
# How to use:
# 1. Simply put it at a proper place. e.g. lib/tasks/ in your Rails application
# 2. Create a config file 'easy_tunnel.yml' like following:
#
# development:
#   public_host_username: host_user_name
#   public_host: url_to_the_public_host
#   public_port: 9000
#   local_port: 3000
#   server_alive_interval: 0
#
# 3. rake easy_tunnel:start
# 4. In your browser http://url_to_the_public_host:9000
#

tunnel_ns = namespace :easy_tunnel do 
  # Courtesy of Christopher Haupt
  # http://www.BuildingWebApps.com
  # http://www.LearningRails.com
  desc "Create a reverse ssh tunnel from a public server to a private development server." 
  task :start => [ :environment, :config ] do  
    puts @notification 
    system @ssh_command
  end 

  desc "Create a reverse ssh tunnel in the background. Requires ssh keys to be setup." 
  task :background_start => [ :environment, :config ] do  
    puts @notification 
    system "#{@ssh_command} > /dev/null 2>&1 &" 
  end 

  # Adapted from Evan Weaver: http://blog.evanweaver.com/articles/2007/07/13/developing-a-facebook-app-locally/ 
  desc "Check if reverse tunnel is running"
  task :status => [ :environment, :config ] do
    if `ssh #{@public_host} -l #{@public_host_username} netstat -an | egrep "tcp.*:#{@public_port}.*LISTEN" | wc`.to_i > 0
      puts "Seems ok"
    else
      puts "Down"
    end
  end

  task :config => :environment do
    tunnel_config = File.join(RAILS_ROOT, 'config', 'easy_tunnel.yml')
    TUNNEL = YAML.load(ERB.new(File.read(tunnel_config)).result)[RAILS_ENV]
    @public_host_username = TUNNEL['public_host_username'] 
    @public_host = TUNNEL['public_host'] 
    @public_port = TUNNEL['public_port'] 
    @local_port = TUNNEL['local_port'] 
    @ssh_port = TUNNEL['ssh_port'] || 22
    @server_alive_interval = TUNNEL['server_alive_interval'] || 0
    @notification = "Starting tunnel #{@public_host}:#{@public_port} to 0.0.0.0:#{@local_port}"
    @notification << " using SSH port #{@ssh_port}" unless @ssh_port == 22
    # "GatewayPorts yes" needs to be enabled in the remote's sshd config
    @ssh_command = %Q[ssh -v -p #{@ssh_port} -nNT4 -o "ServerAliveInterval #{@server_alive_interval}" -R *:#{@public_port}:localhost:#{@local_port} #{@public_host_username}@#{@public_host}]
  end
end  

desc "Create a reverse ssh tunnel from a public server to a private development server."
task :tunnel => tunnel_ns[:start]
