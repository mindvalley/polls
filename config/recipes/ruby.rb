namespace :ruby do
  desc "Install latest stable release of Ruby 1.9.3"
  task :install, roles: :app do
    run "#{sudo} add-apt-repository ppa:brightbox/ruby-ng-experimental"
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install ruby rubygems ruby-switch ruby1.9.3 ruby1.9.1-dev"
    run "#{sudo} ruby-switch --set ruby1.9.1"
    run "#{sudo} gem install bundler"
  end
end