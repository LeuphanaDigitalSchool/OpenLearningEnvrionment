# frozen_string_literal: true
server 'dev.akra.net', port: 5001, user: 'leuphana', roles: %w(web app db)
set :rsync_host, ''

set :rails_env, :production
set :default_shell, '/bin/bash --login'

set :deploy_to, '/home/leuphana/deploy/staging'
set :keep_releases, 5

set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock" # accept array for multi-bind
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_error.log"
set :puma_error_log, "#{shared_path}/log/puma_access.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 1]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_preload_app, false

namespace :angular do
  desc 'Compile and deploy angular app'
  task :deploy do
    on roles(:web) do
      run_locally do
        with rails_env: :production do
          execute 'cd ./client && npm run build'
        end
        execute "rsync -e 'ssh -p 5001' -av --delete --exclude 'uploads'\
                 ./public/ leuphana@dev.akra.net:#{shared_path}/public/client/"
        # execute "ssh -p 5001 leuphana@dev.akra.net 'cd #{shared_path}/public/client;\
        # ln -s #{shared_path}/public/uploads'"
      end
    end
  end
end

namespace :documentation do
  desc 'Generate docs'
  task :generate do
    on roles(:web) do
      run_locally do
        with rails_env: :test do
          execute 'rails docs:generate'
        end
        execute "rsync -av --delete -e 'ssh -p 5001' ./doc/ leuphana@dev.akra.net:#{current_path}/doc/"
      end
    end
  end
end

after 'deploy', 'documentation:generate'
