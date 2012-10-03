require "bundler/capistrano"
require "rvm/capistrano"
load 'deploy/assets'

load "config/recipes/base"

set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"")
set :application, "Polls"
set :server_name, 'polls.mindvalley.net'
set :repository,  "git://github.com/mindvalley/polls.git"
set :user, "mvdev"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :use_sudo, false

set :deploy_via, :remote_cache


# so there is no need to add specific server keys
ssh_options[:forward_agent] = true
namespace :ssh do
  task :start_agent do
    `ssh-add`
  end
end
before 'deploy:update_code', 'ssh:start_agent'
# after "deploy:update", "foreman:export"    # Export foreman scripts
# after "deploy:update", "foreman:restart"   # Restart application scripts

default_run_options[:pty] = true

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :stages, %w(production staging)
set :default_stage, "production"
require 'capistrano/ext/multistage'

namespace :deploy do
  task :restart do
    run "#{sudo} service rainbows_#{application} restart"
  end

  task :stop do
    run "#{sudo} service rainbows_#{application} stop"
  end
end

namespace :foreman do
  desc 'Export the Procfile to Ubuntu upstart scripts'
  task :export, :roles => :app do

    run "cd #{release_path} && rvmsudo bundle exec foreman export upstart /etc/init -a #{application} -u #{user} -l #{release_path}/log/foreman"

  end

  desc "Start the application services"
  task :start, :roles => :app do

    sudo "start #{application}"
  end

  desc "Stop the application services"

  task :stop, :roles => :app do
    sudo "stop #{application}"

  end

  desc "Restart the application services"
  task :restart, :roles => :app do

    run "sudo start #{application} || sudo restart #{application}"
  end
end