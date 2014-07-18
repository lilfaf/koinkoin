# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'soundbot'
set :repo_url, 'https://github.com/lilfaf/koin.git'
set :puma_bind, 'tcp://0.0.0.0:9292'
set :rack_env, 'production'

# Default value for :rvm_type is :auto
set :rvm_type, :user

# Default value for :rvm_ruby_version is 'default'
set :rvm_ruby_version, '2.1.2'

# Default branch is :master
set :branch, 'master'

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/ubuntu/www/koin'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :pty, false

# Default value for :linked_files is []
set :linked_files, %w{.env config/sidekiq.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{tmp/pids tmp/sockets log bin}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 3

# Default value for :sidekiq_config is :nil
set :sidekiq_config, File.join(shared_path, 'config', 'sidekiq.yml')

# Default value for :sidekiq_require is :nil
set :sidekiq_require, File.join(release_path, 'lib', 'koin.rb')

# Default value for :whenever_roles is :db
set :whenever_roles, :app

namespace :deploy do
  task :restart_nginx do
    on roles(:web), wait: 3 do
      execute "sudo service nginx restart"
    end
  end

  after :finished, :restart_nginx
end
