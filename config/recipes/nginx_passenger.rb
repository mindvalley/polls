namespace :nginx_passenger do
  desc 'Setup nginx configuration for this application (with passenger).'
  task :setup, roles: :web do
    template "nginx_passenger.erb", "/tmp/nginx_conf"
    run "#{sudo} mv /tmp/nginx_conf /etc/nginx/sites-enabled/#{application}"
    run "#{sudo} rm -f /etc/nginx/sites-enabled/default"
  end
  after 'nginx_passenger:setup', 'nginx:restart'
  
  desc "Install latest stable release of nginx (with passenger)."
  task :install, roles: :web do
    run "#{sudo} apt-get -y install python-software-properties"
    run "#{sudo} add-apt-repository ppa:brightbox/passenger-nginx"
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install nginx-full"
    run "#{sudo} touch /etc/nginx/conf.d/passenger.conf"
    run "#{sudo} sed -i '$ a\passenger_root /usr/lib/phusion-passenger;' /etc/nginx/conf.d/passenger.conf"
    run "#{sudo} sed -i '$ a\passenger_ruby /usr/bin/ruby;' /etc/nginx/conf.d/passenger.conf"
  end

end