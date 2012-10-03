def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

load "config/recipes/ssh"
load "config/recipes/nginx"
load "config/recipes/nginx_thin"
load "config/recipes/nginx_unicorn"
load "config/recipes/nginx_rainbows"
load "config/recipes/nginx_passenger"
load "config/recipes/ruby"
load "config/recipes/thin"
load "config/recipes/unicorn"
load "config/recipes/rainbows"
load "config/recipes/mongodb"

namespace :deploy do
  desc "Install everything onto the server"
  task :install do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install python-software-properties"
  end
end

namespace :system_stuff do
  task :ensure_dependencies do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install python-software-properties"
  end
  
  desc "Install common pacakges"
  task :common_packages do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install python-software-properties htop iftop iotop mytop sysstat screen curl subversion git-core rsync"
  end
end
