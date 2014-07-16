# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'soundbot'
set :repo_url, 'https://github.com/lilfaf/koin.git'
set :puma_bind, 'tcp://0.0.0.0:9292'

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
set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/.env}

# Default value for linked_dirs is []
set :linked_dirs, %w{tmp/pids tmp/sockets log bin}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 3

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
