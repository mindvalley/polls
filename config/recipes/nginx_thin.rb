namespace :nginx_thin do
  desc "Setup nginx configuration for this application (thin)"
  task :setup, roles: :web do
    template "nginx_thin.erb", "/tmp/nginx_conf"
    run "#{sudo} mv /tmp/nginx_conf /etc/nginx/sites-enabled/#{application}"
    run "#{sudo} rm -f /etc/nginx/sites-enabled/default"
  end
  after 'nginx_thin:setup', 'nginx:restart'
end