namespace :nginx do
  desc "Install latest stable release of nginx"
  task :install, roles: :web do
    run "#{sudo} add-apt-repository ppa:nginx/stable"
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install nginx"
  end
  before "nginx:install", "system_stuff:ensure_dependencies"

  %w[start stop restart].each do |command|
    task command, roles: :web do
      run "#{sudo} service nginx #{command}"
    end
  end
end