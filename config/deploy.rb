# config valid for current version and patch releases of Capistrano
lock "~> 3.17.1"

set :application, "my_app"
set :repo_url, "git@github.com:Kokoro-jp/myapp.git"

set :branch, "main"

append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vender/bundle", "public/system", "public/uploads"

set :ssh_options, {
  auth_methods: ['publickey'],
  keys: ['~/.ssh/myapp-key.pem']
}

set :keep_releases, 5

set :rbenv_type, :user
set :rbenv_ruby, '3.1.3'

# setting of Unicorn
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
