namespace :nginx_rainbows do
  desc "Setup nginx configuration for this application (rainbows)"
  task :setup, roles: :web do
    template "nginx_rainbows.erb", "/tmp/nginx_conf"
    run "#{sudo} mv /tmp/nginx_conf /etc/nginx/sites-enabled/#{application}"
    run "#{sudo} rm -f /etc/nginx/sites-enabled/default"
  end
  after 'nginx_rainbows:setup', 'nginx:restart'
end