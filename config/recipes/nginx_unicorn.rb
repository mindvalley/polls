namespace :nginx_unicorn do
  desc "Setup nginx configuration for this application (unicorn)"
  task :setup, roles: :web do
    template "nginx_unicorn.erb", "/tmp/nginx_conf"
    run "#{sudo} mv /tmp/nginx_conf /etc/nginx/sites-enabled/#{application}"
    run "#{sudo} rm -f /etc/nginx/sites-enabled/default"
  end
  after 'nginx_unicorn:setup', 'nginx:restart'
end