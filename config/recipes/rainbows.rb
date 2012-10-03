set_default(:rainbows_user) { user }
set_default(:rainbows_pid) { "#{current_path}/tmp/pids/rainbows.pid" }
set_default(:rainbows_config) { "#{shared_path}/config/rainbows.rb" }
set_default(:rainbows_log) { "#{shared_path}/log/rainbows.log" }
set_default(:rainbows_workers, 2)

namespace :rainbows do
  desc "Setup Rainbows initializer and app configuration"
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config"
    template "rainbows.erb", rainbows_config
    template "rainbows_init.erb", "/tmp/rainbows_init"
    run "chmod +x /tmp/rainbows_init"
    run "#{sudo} mv /tmp/rainbows_init /etc/init.d/rainbows_#{application}"
    run "#{sudo} update-rc.d -f rainbows_#{application} defaults"
  end

  %w[start stop restart].each do |command|
    desc "#{command} rainbows"
    task command, roles: :app do
      run "service rainbows_#{application} #{command}"
    end
  end
end