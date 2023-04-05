# config valid for current version and patch releases of Capistrano
lock "~> 3.17.2"
# set :git
set :application, "sidekiq-example"
set :repo_url, "https://github.com/somu146/sidekiq-example.git"
ask :branch, :main
# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/user/my_apps'
# Default value for :pty is false
set :pty, true
set :rvm_type, :user
set :rvm_ruby_version, "ruby-3.0.3"
set :default_env, { rvm_bin_path: "~/.rvm/bin" }
set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets tmp/webpacker public/system vendor storage}
# Default value for keep_releases is 5
set :keep_releases, 5

set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"    #accept array for multi-bind
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_error.log"
set :puma_error_log, "#{shared_path}/log/puma_access.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 8]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_preload_app, false

namespace :deploy do
	task :restart_puma do
    on roles(:app) do
      # Restart Puma using the Capistrano Puma task
      invoke 'puma:restart'
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after 'deploy:publishing', 'whenever:update_crontab'
end
