namespace :mongodb do
  desc "Install latest stable release of mongodb"
  task :install, roles: :db do
    run "#{sudo} apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10"
    template "mongodb-10gen.erb", "/tmp/mongodb-10gen.list"
    run "#{sudo} mv /tmp/mongodb-10gen.list /etc/apt/sources.list.d/mongodb-10gen.list"
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install mongodb-10gen"
  end

  %w[start stop restart].each do |command|
    task command, roles: :db do
      run "#{sudo} service mongodb #{command}"
    end
  end
end