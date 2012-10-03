namespace :thin do
  desc "Install the thin server"
  task :install, roles: :app do
    run "#{sudo} gem install thin"
    run "#{sudo} thin install"
    run "#{sudo} /usr/sbin/update-rc.d -f thin defaults"
  end

  desc "Setup the application for thin"
  task :setup, roles: :app do
    run "#{sudo} thin config -C /etc/thin/#{application}.yml -c #{current_path} -e #{stage} --socket /tmp/thin.#{application}.sock --timeout 30"
    run "#{sudo} service thin start"
    run "#{sudo} service thin restart"
  end
end